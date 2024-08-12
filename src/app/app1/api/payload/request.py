from pydantic import BaseModel
from typing import List


class ReqTicker(BaseModel):
    ticker: str
    weight: float
    price: float

class PortfolioCreateRequest(BaseModel):
    investorAccountID: str
    pfName: str
    pfDescription: str
    tickers: List[ReqTicker]