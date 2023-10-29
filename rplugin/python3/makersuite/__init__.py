import os
import re

import google.generativeai as palm
from pynvim import plugin, command

defaults = {
  'model':
    'models/text-bison-001',
  'temperature':
    0.7,
  'candidate_count':
    1,
  'top_k':
    40,
  'top_p':
    0.95,
  'max_output_tokens':
    1024,
  'stop_sequences': [],
  'safety_settings': [{
    "category": "HARM_CATEGORY_DEROGATORY",
    "threshold": 1
  }, {
    "category": "HARM_CATEGORY_TOXICITY",
    "threshold": 1
  }, {
    "category": "HARM_CATEGORY_VIOLENCE",
    "threshold": 2
  }, {
    "category": "HARM_CATEGORY_SEXUAL",
    "threshold": 2
  }, {
    "category": "HARM_CATEGORY_MEDICAL",
    "threshold": 2
  }, {
    "category": "HARM_CATEGORY_DANGEROUS",
    "threshold": 2
  }],
}


@plugin
class MLPlugin(object):

  def __init__(self, nvim):
    self.nvim = nvim

    self.setup = False

  def log(self, message, history=True):
    try:
      for line in message.split('\n'):
        self.nvim.request('nvim_echo', [[line]], history, {})
    except Exception:
      pass

  def get_buf_content(self):
    try:
      buffer = self.nvim.current.buffer
      bufnr = buffer.number
      lines = self.nvim.request('nvim_buf_get_lines', bufnr, 0, -1, False)
      return '\n'.join(lines)
    except Exception:
      pass
    return ''

  def setup_palm(self):
    if self.setup:
      return

    key_path = os.path.join(
      os.getenv('HOME'), '.local', 'makersuite-api-key.txt')
    self.log('🧰 loading google PALM API key...')
    if os.path.exists(key_path):
      with open(key_path, 'r') as f:
        api_key = f.read().strip()
        palm.configure(api_key=api_key)
        self.log('✅ setup google PALM')
        self.setup = True

  def prepare_flutter_widget_prompt(self, content):
    return f"""Write unit test for the following flutter widget:

```dart
{content}
```
"""

  def prepare_cpp_prompt(self, content):
    return f"""Write unit test using gtest for the following cpp code:

```cpp
{content}
```
"""

  def prepare_java_prompt(self, content):
    return f"""Write unit test using junit for the following java code:

```java
{content}
```
"""

  def prepare_js_prompt(self, content):
    return f"""Write unit test for the following node javascript code:

```javascript
{content}
```
"""

  def prepare_react_prompt(self, content):
    return f"""Write unit test using jest for the following react component code:

```javascript
{content}
```
"""

  def get_file_type(self):
    try:
      buffer = self.nvim.current.buffer
      bufnr = buffer.number
      return self.nvim.request('nvim_buf_get_option', bufnr, 'filetype')
    except Exception:
      pass
    return ''

  def prepare_prompt(self):
    filetype = self.get_file_type()
    content = self.get_buf_content()
    if filetype == 'dart':
      return self.prepare_flutter_widget_prompt(content)
    elif filetype == 'cpp' or filetype == 'c':
      return self.prepare_cpp_prompt(content)
    elif filetype == 'java':
      return self.prepare_java_prompt(content)
    elif filetype == 'javascript':
      return self.prepare_js_prompt(content)
    return None

  def extract_code(self, content):
    p = re.compile(r'```(.*)\n([^`]*)```')
    code = p.findall(content)
    return '\n\n'.join([c[1] for c in code])

  def create_test_file(self, content):
    filename = self.nvim.funcs.expand('%:t')
    self.nvim.command('e test/test_' + filename)
    buffer = self.nvim.current.buffer
    buffer.append(content.split('\n'), 0)

  def send_request(self, prompt):
    response = palm.generate_text(
      **defaults,
      prompt=prompt
    )
    return self.extract_code(response.result)

  @command('GenTest')
  def gen_test(self):
    self.setup_palm()

    self.log('🧸🧸🧸 generating test...')
    prompt = self.prepare_prompt()
    if prompt:
      code = self.send_request(prompt)
      self.create_test_file(code)
    else:
      self.log('🦔 🦔 🦔 prompt not ready yet...')

  def prepare_code_request(self, r):
    buf = self.nvim.current.buffer
    start = r[0] - 1
    end = r[1]
    lines = buf[start:end]
    return lines

  def create_jest_test_file(self, content):
    filepath = self.nvim.funcs.expand('%')
    p = filepath.split('.')
    extension = p[-1]
    filepath = '.'.join(p[:-1]) + '.test.' + extension
    self.nvim.command('e ' + filepath)
    buffer = self.nvim.current.buffer
    buffer.append(content.split('\n'), 0)

  @command('JestReactTest', nargs='*', range='')
  def gen_react_test(self, args, r):
    selected_code = self.prepare_code_request(r)
    prompt = self.prepare_react_prompt(selected_code)
    code = self.send_request(prompt)
    self.create_jest_test_file(code)
