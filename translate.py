#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import six
import sys
from google.cloud import translate_v2 as translate
from argparse import ArgumentParser


parser = ArgumentParser()
parser.add_argument('--target', default='zh-TW')
args = parser.parse_args()


## example from https://cloud.google.com/translate/docs/basic/translate-text-basic#translate_translate_text-python
def translate_text(target, text):
  """Translates text into the target language.
  Target must be an ISO 639-1 language code.
  See https://g.co/cloud/translate/v2/translate-reference#supported_languages
  """

  translate_client = translate.Client()

  if isinstance(text, six.binary_type):
      text = text.decode("utf-8")

  # Text can also be a sequence of strings, in which case this method
  # will return a sequence of results for each text.
  result = translate_client.translate(text, target_language=target)

  #  print(u"Text: {}".format(result["input"]))
  #  print(u"Translation: {}".format(result["translatedText"]))
  #  print(u"Detected source language: {}".format(result["detectedSourceLanguage"]))
  return result


def main():
  lines = sys.stdin.readlines()
  output = []
  for line in lines:
    result = translate_text(args.target, line.strip())
    translated = result['translatedText']
    output.append(translated)
  print('\n'.join(output))


if __name__ == '__main__':
  main()
