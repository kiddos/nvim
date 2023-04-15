#!/bin/env bash

python -m grpc_tools.protoc -Iproto --python_out=. --grpc_python_out=. proto/editor.proto
