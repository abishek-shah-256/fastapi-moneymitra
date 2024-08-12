#!usr/bin/python3
""" Route: Master Data Operations
 Add or Modify existing Master Data vital to the operations of the tests
 provided as for by the functional user  belonging to an organization """
from __future__ import annotations
from http import HTTPStatus

# IMPORTS
from fastapi import APIRouter, status
from fastapi.encoders import jsonable_encoder
from starlette.responses import JSONResponse
from datetime import datetime

from src.app import logs
from src.app.app_enum.response_code import ResponseCode
from src.app.core.generic_payload.generic_request import GenericRequest
from src.app.core.generic_payload.generic_response import GenericResponse
from src.app.app1.api.payload.request import PortfolioCreateRequest
from src.app.app1.api.service import PortfolioService


# CONTROL LAYER DEFINITIONS
portfolio_service_obj = PortfolioService()
route_controller = APIRouter(prefix="/api/v3/data")


# PATH DEFINITIONS
@route_controller.post(
    path="/create",
    tags=["Portfolio Details"],
    summary="Save the portfolio",
    status_code=200,
    response_model=GenericResponse,
)
async def create_portfolio(
    request: GenericRequest[PortfolioCreateRequest],
):
    """Router Function for saving the portfolio tickers"""
    # LOGS
    logs.info(f"Portfolio Creation Started")

    # INITIALIZATIONS
    respond = GenericResponse

    # SERVICE-CALLS
    service_response = portfolio_service_obj.save_portfolio(
        request.data
    )
    
    # CASE CHECK [SUCCESS/FAILURE]
    if service_response is not None:
        respond.responseCode = ResponseCode.SUCCESS
        respond.httpStatusCode = HTTPStatus.CREATED
        respond.timeStamp = datetime.now()
        respond.message = "Portfolio Saved Successfully"
        respond.data = service_response
    else:
        respond.responseCode = ResponseCode.FAILED
        respond.message = "ERROR: Failed to Save"

    # RETURNS
    return JSONResponse(
        status_code=status.HTTP_200_OK,
        content=jsonable_encoder(GenericResponse(**respond.__dict__).model_dump()),
    )
