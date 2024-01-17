require('plugins').setup()
require('lsp').setup()
require('commands').setup()
require('options').setup()

local server = require('server')
server.start_apm_server()
-- server.start_codellama_code_server()
-- server.start_codellama_instruct_server()

require('gemini').setup()
