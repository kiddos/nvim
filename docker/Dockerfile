# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /app

COPY docker-requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY codet5-base-javascript /app/codet5-base-javascript
COPY ./ml_rpc_server.py .
COPY ./ml_pb2.py .
COPY ./ml_pb2_grpc.py .

CMD ["python3", "ml_rpc_server.py"]
