import random, string
from sqlalchemy import Column
from sqlalchemy import String, TIMESTAMP, BIGINT, FLOAT, func
from src.app.database.data_connector import Base
from src.app.core.common.models import TimeStampMixin

def generate_manual_uuid():
    return "".join(random.choices(string.digits + string.ascii_letters, k=7))


class PortfolioData(Base, TimeStampMixin):
    __tablename__ = 'portfolio_data_advisory'
    __table_args__ = {"quote": False, "extend_existing": True, "schema": "public"}
    seqid = Column(name="pf_seqid",type_=BIGINT,primary_key=True)
    investor_id = Column(name="investor_account_id", type_=String)
    pfid=Column(name="pf_advid",type_=String, default=generate_manual_uuid)
    pf_name = Column(name="pf_name",type_=String)
    pf_description = Column(name="pf_description",type_=String)
    ticker = Column(name="pf_ticker",type_=String)
    weight = Column(name="pf_weight",type_=FLOAT)
    price = Column(name="pf_price",type_=FLOAT)
    created_date=Column(name="created_date",type_=TIMESTAMP, nullable=False, default=func.now())
    modified_date=Column(name="modified_date",type_=TIMESTAMP)
