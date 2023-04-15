#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import logging
from concurrent import futures
from time import time
from threading import Thread
from argparse import ArgumentParser
import socket
import psutil
import os

from pynput.keyboard import Key, Listener
import grpc
from editor_pb2 import APMResponse
import editor_pb2_grpc


parser = ArgumentParser()
parser.add_argument('--port', default=50051, type=int, help='grpc port to use')
parser.add_argument('--timeout', default=60, type=int, help='timeout')
parser.add_argument('--debug', default=True, type=bool, help='debug mode')
args = parser.parse_args()


logging.basicConfig()
logger = logging.getLogger('apm')
logger.setLevel(logging.INFO)


class InputListener(object):
  def __init__(self):
    self.start_time = time()
    self.actions = 0
    self.last_pressed = time()

  def on_press(self, key):
    self.actions += 1
    self.last_pressed = time()

  def on_release(self, key):
    if args.debug:
      logger.info('apm: %f', self.compute_apm())
    if args.debug and key == Key.esc:
      # Stop listener
      return False

  def compute_apm(self):
    passed = time() - self.start_time
    if self.last_pressed - self.start_time > args.timeout:
      self.actions = 0
      self.start_time = time()
    return self.actions / passed * 60.0

  def start(self):
    try:
      with Listener(on_press=self.on_press, on_release=self.on_release) as listener:
        listener.join()
    except KeyboardInterrupt:
      logger.info('stop key listener')


class EditorServicer(editor_pb2_grpc.EditorServicer):
  def __init__(self):
    self.listener = InputListener()
    self.start_listener()

  def start_listener(self):
    self.listener_task = Thread(target=self.listener.start)
    self.listener_task.start()

  def GetAPM(self, request, context):
    apm = self.listener.compute_apm()
    return APMResponse(apm=apm)


def is_port_in_use(port: int) -> bool:
  with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    return s.connect_ex(('localhost', port)) == 0


def main():
  if is_port_in_use(args.port):
    logger.info('grpc server already started')
    return

  p = psutil.Process(os.getpid())
  p.nice(16)

  server = grpc.server(futures.ThreadPoolExecutor(max_workers=1))
  editor_pb2_grpc.add_EditorServicer_to_server(EditorServicer(), server)
  server.add_insecure_port(f'[::]:{args.port}')
  server.start()
  server.wait_for_termination()


if __name__ == '__main__':
  main()
