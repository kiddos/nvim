#!/bin/env bash

python -m grpc_tools.protoc -Iproto --python_out=./scripts --grpc_python_out=./scripts proto/editor.proto

python -m grpc_tools.protoc -Iproto --python_out=./scripts --grpc_python_out=./scripts proto/ml.proto

python -m grpc_tools.protoc -Iproto --python_out=./rplugin/python3/ml --grpc_python_out=./rplugin/python3/ml proto/ml.proto

sed -i "s/import ml_pb2 as ml__pb2/from . import ml_pb2 as ml__pb2/g" rplugin/python3/ml/ml_pb2_grpc.py
