
apt update && apt upgrade -y

apt install -y -q build-essentials python3-pip python3-dev
pip3 install -U pip setuptools wheel
pip3 install gunicorn uvloop httptools

cp ./requirements.txt /Tenbps/requirements.txt

pip3 install -r /Tenbps/requirements.txt

cp ./src/ /Tenbps

/usr/local/bin/gunicorn \
  -b 0.0.0.0:8065
  -w 4  \
  -k uvicorn.works.UvicornWorker app:api  \
  --chdir /Tenbps
