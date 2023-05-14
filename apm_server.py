#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import logging
from concurrent import futures
from time import time
from threading import Thread
from argparse import ArgumentParser
from collections import deque
import socket
import psutil
import os

from pynput import keyboard
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
    self.actions = deque()

  def on_press(self, key):
    self.actions.append(dict(
      time=time(),
      key=key,
    ))

  def on_release(self, key):
    if args.debug:
      logger.info('apm: %f', self.compute_apm())
    if args.debug and key == keyboard.Key.esc:
      pass

  def compute_apm(self):
    current = time()
    while len(self.actions) > 0 and current - self.actions[0]['time'] > args.timeout:
      self.actions.popleft()
    num_action = len(self.actions)
    t0 = 0
    if len(self.actions) > 0:
      t0 = self.actions[0]['time']
    passed = current - max(t0, 1e-6)
    apm = num_action / passed * 60.0
    return apm

  def start(self):
    try:
      with keyboard.Listener(on_press=self.on_press, on_release=self.on_release) as listener:
        listener.join()
    except Exception as e:
      logger.error('listener stopped', e)


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
