from src.app import logs
from src.app.app1.repository import PortfolioDataRepo
from src.app.app1.api.payload.response import PortfolioCreatedResponse


class PortfolioService:
    def __init__(self):
        self.__portfolioRepo = PortfolioDataRepo()

    def save_portfolio(self, portfolio):
        logs.info("Portfolio Insertion Started")

        portfolio_response = []
        for data in portfolio.tickers:
            portfolio_dict = {
                'investor_id': portfolio.investorAccountID,
                'pf_name': portfolio.pfName,
                'pf_description': portfolio.pfDescription,
                'ticker': data.ticker,
                'weight': data.weight/100,
                'price': data.price
            }
            portfolio_ticker = {'ticker': data.ticker, 'weight': data.weight/100, 'price': data.price}
            portfolio_response.append(portfolio_ticker)
            self.__portfolioRepo.insert_portfolio_data(portfolio_dict)

        logs.info(f"Portfolio Inserted Successfully")
        response = PortfolioCreatedResponse(tickers=portfolio_response, portfolioName=portfolio.pfName, portfolioDescription=portfolio.pfDescription)
        return response