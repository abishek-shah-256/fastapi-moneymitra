from fastapi import __version__ as fastapi_ver
import art
from datetime import datetime

filler = "=".center(35, "=")
print(art.text2art("FastAPI") + f"FastAPI {filler} {fastapi_ver}\n")
print(
    art.text2art("MoneyMitra apps")
    + "\t\t\t\t\t\t ver-3.0 \n\t\t\t\t\t\t Money Mitra Services \n"
)
print(" Started on : ", datetime.now().strftime("%m/%d/%Y, %H:%M:%S"))
