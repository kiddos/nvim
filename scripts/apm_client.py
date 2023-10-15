#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import logging
from time import time
import psutil
import os

import grpc
from editor_pb2 import APMRequest
from editor_pb2_grpc import EditorStub


def get_apm(stub):
  current_time_millis = round(time() * 1000)
  request = APMRequest(time=current_time_millis)
  response = stub.GetAPM(request)
  print('%.2f' % response.apm)


def main():
  p = psutil.Process(os.getpid())
  p.nice(16)

  try:
    with grpc.insecure_channel('localhost:50051') as channel:
      stub = EditorStub(channel)
      get_apm(stub)
  except Exception:
    pass


if __name__ == '__main__':
  logging.basicConfig()
  main()
