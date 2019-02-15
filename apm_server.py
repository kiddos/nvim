#!/usr/bin/env python
# -*- coding: utf-8 -*-

from time import time, sleep
from threading import Thread
import logging
from argparse import ArgumentParser


from pynput.keyboard import Key, Listener
import psutil
import asyncore
import socket


def str2bool(v):
  if v.lower() in ('yes', 'true', 't', 'y', '1'):
    return True
  elif v.lower() in ('no', 'false', 'f', 'n', '0'):
    return False
  else:
    return True


parser = ArgumentParser()
parser.add_argument('--timeout', default=60, type=int,
  help='timeout')
parser.add_argument('--debug', default=True, type=str2bool,
  help='debug mode')
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
      with Listener(on_press=self.on_press,
          on_release=self.on_release) as listener:
        listener.join()
    except KeyboardInterrupt:
      logger.info('stop key listener')


class APMServer(asyncore.dispatcher):
  def __init__(self, host, port):
    asyncore.dispatcher.__init__(self)
    self.create_socket(socket.AF_INET, socket.SOCK_STREAM)
    self.set_reuse_addr()
    self.bind((host, port))
    self.listen(1)

    self.listener = InputListener()

  def handle_accept(self):
    pair = self.accept()
    if pair is not None:
      sock, addr = pair
      sock.sendall('% 4.2f' % self.listener.compute_apm())

  def start_asyncore(self):
    try:
      asyncore.loop()
    except KeyboardInterrupt:
      logger.info('stop apm server')


  def start_both(self):
    try:
      listener_task = Thread(target=self.listener.start)
      listener_task.start()

      server_task = Thread(target=self.start_asyncore)
      server_task.daemon = True
      server_task.start()

      listener_task.join()
    except KeyboardInterrupt:
      logger.info('stopped')


def main():
  try:
    server = APMServer('localhost', 9006)
    server.start_both()
  except socket.error:
    logger.error('process started')


if __name__ == '__main__':
  main()
