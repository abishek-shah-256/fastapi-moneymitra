#!usr/bin/python3

""" Generic Models for response """
from datetime import datetime
from http import HTTPStatus
from typing import Generic, TypeVar

from pydantic import BaseModel

from src.app.app_enum.response_code import ResponseCode

# Type Definition for Generalization
T = TypeVar("T")


class ErrorDetails(BaseModel):
    errorCode: int = None
    errorMessage: str = None

class GenericError(BaseModel):
    errorsList: list[ErrorDetails] = []

class GenericResponse(BaseModel, Generic[T]):
    responseCode: ResponseCode | None = None
    httpStatusCode: HTTPStatus | None = None
    message: str | None = None
    timeStamp: datetime | None = None
    errorDetails: GenericError | None = None
    data: T | None = None
    dataList: list[T] | None = []
    dropDownMap: dict | None = {}
    totalRecords: int | None = 0
    pageIndex: int | None = 0
    pageSize: int | None = 0
    totalPages: int | None = 0
