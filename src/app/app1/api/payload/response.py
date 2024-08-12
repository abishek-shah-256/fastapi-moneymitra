from pydantic import BaseModel
from typing import List


class ReqTicker(BaseModel):
    ticker: str
    weight: float
    price: float

class PortfolioCreatedResponse(BaseModel):
    tickers: List[ReqTicker]
    portfolioName: str
    portfolioDescription: str
    