import grpc
from typing import List
from pynvim import plugin, command

from .ml_pb2 import Code, CodeCompletion, Comment, Instruction, Implementation, Example
from .ml_pb2_grpc import MLStub

RPC1_HOST = 'localhost:60001'
RPC2_HOST = 'localhost:60002'


def get_code_completion(rpc: str, request: Code) -> CodeCompletion:
  try:
    with grpc.insecure_channel(rpc) as channel:
      stub = MLStub(channel)
      response = stub.GetCodeCompletion(request)
    return response
  except Exception:
    return None


def generate_comment(rpc: str, request: Code) -> Comment:
  try:
    with grpc.insecure_channel(rpc) as channel:
      stub = MLStub(channel)
      response = stub.GenerateComment(request)
    return response
  except Exception:
    return None


def generate_implementation(rpc: str, request: Instruction) -> Implementation:
  try:
    with grpc.insecure_channel(rpc) as channel:
      stub = MLStub(channel)
      response = stub.GenerateImplementation(request)
    return response
  except Exception:
    return None


def generate_test(rpc: str, request: Code) -> Implementation:
  try:
    with grpc.insecure_channel(rpc) as channel:
      stub = MLStub(channel)
      response = stub.GenerateTest(request)
    return response
  except Exception:
    return None


def generate_example(rpc: str, request: Code) -> Example:
  try:
    with grpc.insecure_channel(rpc) as channel:
      stub = MLStub(channel)
      response = stub.GenerateExample(request)
    return response
  except Exception:
    return None


@plugin
class MLPlugin(object):

  def __init__(self, nvim):
    self.nvim = nvim

  def get_buf_filetype(self):
    try:
      return self.nvim.request(
        'nvim_buf_get_option',
        self.nvim.current.buffer.number,
        'filetype',
      )
    except Exception:
      return ''

  def log(self, message, history=True):
    try:
      self.nvim.request('nvim_echo', [[message]], history)
    except Exception:
      pass

  def error(self, message):
    try:
      self.nvim.request('nvim_err_writeln', message)
    except Exception:
      pass

  def prepare_code_request(self, r):
    buf = self.nvim.current.buffer
    language = self.get_buf_filetype()
    start = r[0] - 1
    end = r[1]
    lines = buf[start:end]
    buf_text = '\n'.join(lines)
    return Code(language=language, code=buf_text, start=start, end=end)

  def prepare_instruction_request(self, r):
    language = self.get_buf_filetype()

    buf = self.nvim.current.buffer
    start = r[0] - 1
    end = r[1]
    lines = buf[start:end]
    buf_text = '\n'.join(lines)
    return Instruction(language=language, instruction=buf_text)

  def append_text(self, result: List[str], at: int):
    if len(result) == 0:
      self.error('no result')
      return

    result = [code.strip() for code in result]
    text = '\n\n'.join(result)
    buf = self.nvim.current.buffer
    buf.append(text.split('\n'), at)

  @command('LLMCode', nargs='*', range='')
  def get_completion(self, args, r):
    code = self.prepare_code_request(r)
    response = get_code_completion(RPC2_HOST, code)
    if not response:
      self.error('fail to request server')
      return

    self.append_text(response.completions, r[1])

  def append_comments(self, comments, at):
    if not comments or len(comments) == 0:
      return

    buf = self.nvim.current.buffer
    filetype = self.get_buf_filetype()
    if filetype == 'python' or filetype == 'lua':
      lines = comments.split('\n')
      buf.append(lines, at)
    elif filetype == 'cpp' or filetype == 'c' or filetype == 'java':
      lines = comments.split('\n')
      to_insert = ['/*'] + [' * ' + line for line in lines] + [' */']
      buf.append(to_insert, at)
    elif filetype == 'dart' or filetype == 'javascript' or filetype == 'typescript':
      lines = comments.split('\n')
      to_insert = ['// ' + line for line in lines]
      buf.append(to_insert, at)

  @command('Document', nargs='*', range='')
  def generate_comment(self, args, r):
    code = self.prepare_code_request(r)
    response = generate_comment(RPC2_HOST, code)

    if not response:
      self.error('fail to request server')
      return

    self.append_comments(response.comment, r[0]-1)

  @command('Implement', nargs='*', range='')
  def generate_implemntation(self, args, r):
    instruction = self.prepare_instruction_request(r)
    response = generate_implementation(RPC2_HOST, instruction)

    if not response:
      self.error('fail to request server')
      return

    self.append_text(response.implementations, r[1])

  @command('Test', nargs='*', range='')
  def generate_test(self, args, r):
    code = self.prepare_code_request(r)
    response = generate_test(RPC2_HOST, code)

    if not response:
      self.error('fail to request server')
      return

    self.append_text(response.implementations, r[0]-1)

  @command('Example', nargs='*', range='')
  def generate_example(self, args, r):
    code = self.prepare_code_request(r)
    response = generate_example(RPC2_HOST, code)

    if not response:
      self.error('fail to request server')
      return

    self.append_text(response.examples, r[0]-1)
