#!/bin/env bash

python -m grpc_tools.protoc -Iproto --python_out=. --grpc_python_out=. proto/editor.proto

# python -m grpc_tools.protoc -Iproto --python_out=rplugin/python3/ml --grpc_python_out=rplugin/python3/ml proto/ml.proto
