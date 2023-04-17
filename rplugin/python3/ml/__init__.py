import logging
import os

from pynvim import plugin, command, autocmd


log_file = os.path.join(os.getenv('HOME'), '.local', 'ml.log')
logging.basicConfig()
logger = logging.getLogger('ml')
logger.addHandler(logging.FileHandler(log_file))
logger.setLevel(logging.INFO)


onnx_path = os.path.join(os.getenv('HOME'), 'onnx')
js_doc_checkpoint = os.path.join(onnx_path, 'doc-gen', 'codet5-base-javascript')


@plugin
class MLPlugin(object):
  def __init__(self, nvim):
    self.nvim = nvim

  def generate_js_doc(self, r):
    buf = self.nvim.current.buffer
    if not hasattr(self, 'js_doc_pipeline'):
      logger.info('no model loaded')
      return

    start = r[0]-1
    end = r[1]
    lines = buf[start:end]
    buf_text = '\n'.join(lines)
    doc = self.js_doc_pipeline(buf_text, max_length=200)
    doc_lines = doc[0]['generated_text'].split('\n')
    to_insert = ['/*'] + [' * ' + line for line in doc_lines] + [' */']
    buf.append(to_insert, start)

  @command('GenerateDoc', nargs='*', range='')
  def generate_doc(self, args, r):
    buf = self.nvim.current.buffer
    if buf.name.endswith('.js'):
      self.generate_js_doc(r)

  def load_pipeline(self, checkpoint):
    from transformers import AutoTokenizer
    from optimum.onnxruntime import ORTModelForSeq2SeqLM
    from optimum.pipelines import pipeline as op_pipeline

    if not os.path.exists(checkpoint):
      logger.warn(f'{checkpoint} not found')
      return

    tokenizer = AutoTokenizer.from_pretrained(checkpoint)
    ort_model = ORTModelForSeq2SeqLM.from_pretrained(checkpoint)

    logger.info(f'setting up model from {js_doc_checkpoint}...')
    return op_pipeline(
      'text2text-generation',
      model=ort_model,
      tokenizer=tokenizer
    )

  @autocmd('BufEnter', pattern='*.js')
  def on_js_bufenter(self):
    if hasattr(self, 'js_doc_pipeline'):
      logger.info('pipeline loaded')
      return

    self.js_doc_pipeline = self.load_pipeline(js_doc_checkpoint)
    self.nvim.out_write(f'{js_doc_checkpoint} loaded.\n')
