#!usr/bin/python3
""" Generic App Requests body """
from typing import TypeVar, Generic, Optional
from pydantic import BaseModel

# Type Definition for Generalization
T = TypeVar("T")


class GenericRequest(BaseModel, Generic[T]):
    data: T
    pageIndex: Optional[int] = 1
    pageSize: Optional[int] = 100
    searchCriteria: dict | None = None
    sortCriteria: dict | None = None
