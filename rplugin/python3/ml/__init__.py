import grpc
from pynvim import plugin, command, autocmd


from .ml_pb2 import DocumentRequest
from .ml_pb2_grpc import MLStub


RPC_HOST = 'localhost:50052'


def generate_doc(language, text):
  try:
    with grpc.insecure_channel(RPC_HOST) as channel:
      stub = MLStub(channel)
      request = DocumentRequest(language=language, num_response=1, code=text)
      response = stub.GenerateDocument(request)
    return response
  except Exception:
    return None


@plugin
class MLPlugin(object):
  def __init__(self, nvim):
    self.nvim = nvim

  def generate_js_doc(self, r):
    buf = self.nvim.current.buffer
    start = r[0]-1
    end = r[1]
    lines = buf[start:end]
    buf_text = '\n'.join(lines)
    response = generate_doc('js', buf_text)
    if not response:
      return

    doc = response.doc
    self.nvim.command('echo ' + str(doc))

    doc_lines = doc[0].split('\n')
    to_insert = ['/*'] + [' * ' + line for line in doc_lines] + [' */']
    buf.append(to_insert, start)

  @command('GenerateDoc', nargs='*', range='')
  def generate_doc(self, args, r):
    buf = self.nvim.current.buffer
    if buf.name.endswith('.js'):
      self.generate_js_doc(r)

  @autocmd('BufEnter', pattern='*.js')
  def on_js_bufenter(self):
    pass
