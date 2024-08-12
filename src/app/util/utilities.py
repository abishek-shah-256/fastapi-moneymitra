from typing import Any

import pandas
from sqlalchemy import Sequence, Row



def dictFromRow(row: dict):
    """Generate Dictionary object from SQLAlchemy Row Object
    to use in Response body"""
    # INITIALIZATION
    data_row_dict = {}
    # OPERATIONS
    for item in row.__dict__:
        if not str(item).startswith("_"):
            data_row_dict[item] = row.__dict__[item]
    # RETURNS
    return data_row_dict


def frameFromSequence(dataSequence) -> pandas.DataFrame:
    """ Generate a Dataframe from SQLAlchemy Row Sequence """
    # INITIALIZATIONS
    dataList = []
    # OPERATIONS
    for dataRow in dataSequence:
        dataList.append(dictFromRow(dataRow[0]))
    # RETURNS
    return pandas.DataFrame(dataList)
