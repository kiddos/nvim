#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import logging
import sys
import socket
from concurrent import futures
from argparse import ArgumentParser
import multiprocessing

import grpc
import transformers
from transformers import AutoTokenizer
from optimum.pipelines import pipeline as op_pipeline
from optimum.onnxruntime import ORTModelForSeq2SeqLM

from ml_pb2 import DocumentRequest, DocumentResponse
from ml_pb2 import CommitRequest, CommitResponse
import ml_pb2_grpc


parser = ArgumentParser()
parser.add_argument('--port', default=50052, type=int, help='grpc port to use')
parser.add_argument('--js_doc_model', default='./codet5-base-javascript')
args = parser.parse_args()

logging.basicConfig(
  format="%(asctime)s [%(levelname)s] %(message)s",
)
logger = logging.getLogger('ml_rpc_server')
logger.addHandler(logging.StreamHandler(sys.stdout))
logger.setLevel(logging.INFO)
logger.info(f'transformer version: {transformers.__version__}')


logger.info('starting js doc model: %s...', args.js_doc_model)
tokenizer = AutoTokenizer.from_pretrained(args.js_doc_model)
js_doc_model = ORTModelForSeq2SeqLM.from_pretrained(args.js_doc_model)
js_doc_pipeline = op_pipeline('text2text-generation', model=js_doc_model, tokenizer=tokenizer)


class MLServicer(ml_pb2_grpc.MLServicer):
  def __init__(self):
    self.pipelines = {}
    self.use_count = {}

  def GenerateDocument(self, request: DocumentRequest, context):
    doc = []
    if request.language == 'js':
      args = dict()
      if request.num_response > 1:
        args['num_return_sequences'] = request.num_response
        args['do_sample'] = True
      result = js_doc_pipeline(request.code, *args)
      for entry in result:
        doc.append(entry['generated_text'])
    return DocumentResponse(doc=doc)

  def GenerateCommit(self, request: CommitRequest, context):
    # TODO
    commit_msgs = []
    return CommitResponse(commit_msgs=commit_msgs)


def is_port_in_use(port: int) -> bool:
  with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    return s.connect_ex(('localhost', port)) == 0


def main():
  if is_port_in_use(args.port):
    logger.info('grpc server already started')
    return

  num_workers = multiprocessing.cpu_count()

  logger.info('starting server with %d workers...', num_workers)

  server = grpc.server(futures.ThreadPoolExecutor(max_workers=num_workers))
  ml_pb2_grpc.add_MLServicer_to_server(MLServicer(), server)
  server.add_insecure_port(f'[::]:{args.port}')
  server.start()
  server.wait_for_termination()


if __name__ == '__main__':
  main()
