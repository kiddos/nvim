#!/bin/env bash

python -m grpc_tools.protoc -Iproto --python_out=. --grpc_python_out=. proto/editor.proto

python -m grpc_tools.protoc -Iproto --python_out=./rplugin/python3/ml --grpc_python_out=./rplugin/python3/ml proto/ml.proto

cp $HOME/onnx/doc-gen/codet5-base-javascript .

docker build --tag ml-local-server .

docker run -d -p 50052:50052 --name ml-server ml-local-server

rm -r codet5-base-javascript
