import os
import logging
from argparse import ArgumentParser

from transformers import AutoTokenizer
from optimum.onnxruntime import ORTModelForSeq2SeqLM


parser = ArgumentParser()
parser.add_argument('model_name', type=str, help='model name')
parser.add_argument('output_path', type=str, help='onnx output path')
args = parser.parse_args()

logging.basicConfig()
logger = logging.getLogger('model')
logger.setLevel(logging.INFO)


def export_model(name, location):
  if not os.path.exists(location):
    os.makedirs(location)

  logger.info(f'exporting {name} to {location}...')
  model = ORTModelForSeq2SeqLM.from_pretrained(name, export=True)
  tokenizer = AutoTokenizer.from_pretrained(name)

  model.save_pretrained(location)
  tokenizer.save_pretrained(location)


def main():
  export_model(args.model_name, args.output_path)


if __name__ == '__main__':
  main()
