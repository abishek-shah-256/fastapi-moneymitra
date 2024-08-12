from datetime import datetime
from fastapi import FastAPI, Request, status
from fastapi.encoders import jsonable_encoder
from starlette.responses import JSONResponse
from fastapi.exceptions import RequestValidationError

from src.app import logs
from src.app.app_enum.response_code import ResponseCode
from src.app.exception.app_runtime_exception import AppRuntimeException
from src.app.exception.generic_app_exception import GenericAppException

from src.app.core.generic_payload.generic_response import ErrorDetails, GenericError
from src.app.core.generic_payload.generic_response import GenericResponse


def generateResponse(ecp: Exception) -> GenericResponse:
    """All Exception handling function"""
    response = GenericResponse()
    response.responseCode = ResponseCode.FAILED.value
    error = GenericError()
    err_dtl = ErrorDetails()
    err_dtl.errorCode = ecp.errorCode if hasattr(ecp, "errorCode") else 500
    err_dtl.errorMessage = ecp.errorMsg if hasattr(ecp, "errorMsg") else str(ecp)
    error.errorsList.append(err_dtl)
    response.httpStatusCode = ecp.errorCode if hasattr(ecp, "errorCode") else 500
    response.message = ecp.errorMsg if hasattr(ecp, "errorMsg") else str(ecp)
    response.timeStamp = datetime.now()
    response.errorDetails = error
    # Returns
    return response


def initiate_exception_handling(app_route_advisor: FastAPI):
    """INITIALIZES ALL EXCEPTION TYPE & RESPONSES"""

    logs.info(" ROUTER-MM: EXCEPTION HANDLERS INITIALIZED ")

    @app_route_advisor.exception_handler(AppRuntimeException)
    async def app_runtime_exception_handler(request: Request, exc: AppRuntimeException):
        """Exception handler for Application Runtime Errors"""
        response = generateResponse(exc)
        return JSONResponse(
            status_code=400,
            content=jsonable_encoder(GenericResponse(**response.__dict__).model_dump()),
        )

    @app_route_advisor.exception_handler(FileNotFoundError)
    async def file_not_found_exception_handler(
        request: Request, exc: FileNotFoundError
    ):
        """Exception handler for Missing File Errors"""
        response = generateResponse(exc)
        return JSONResponse(
            status_code=404,
            content=jsonable_encoder(GenericResponse(**response.__dict__).model_dump()),
        )

    @app_route_advisor.exception_handler(GenericAppException)
    async def generic_app_exception_handler(request: Request, exc: GenericAppException):
        """Exception handler for All Generic Application Exceptions"""
        response = generateResponse(exc)
        return JSONResponse(
            status_code=exc.errorCode,
            content=jsonable_encoder(GenericResponse(**response.__dict__).model_dump()),
        )

    @app_route_advisor.exception_handler(RequestValidationError)
    async def request_validation_error_handler(request: Request, exc: RequestValidationError):
        """Exception handler for FastAPI Request Validation Errors"""
        error_msg = exc.errors()
        raise GenericAppException(errCode=status.HTTP_422_UNPROCESSABLE_ENTITY, errMsg=error_msg[0]['msg'])