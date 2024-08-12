from sqlalchemy.exc import SQLAlchemyError

from src.app.config.generic_config import GenericConfig
from main import logs
from src.app.database.data_connector import DBConnection
import src.app.constants.app_constants as _const
# from src.app.exception.generic_app_exception import GenericAppException
from src.app.app1.models import PortfolioData


class PortfolioDataRepo:
    def __init__(self):
        # pull configurations
        config = GenericConfig()
        config_details = config.get_connection_details(_const.DATABASE_1)
        self.cursor, self.conn = DBConnection.get_db_connection_cursor(**config_details)
        self.session, self.engine = DBConnection.get_db_session_creator(**config_details)

    
    def insert_portfolio_data(self, data: dict):
        try:
            portfolio_data = PortfolioData(**data)
            self.session.add(portfolio_data)
            self.session.commit()
        except SQLAlchemyError as e:
            logs.error(f"Error inserting the portfolio data: {e}")
            self.session.rollback()