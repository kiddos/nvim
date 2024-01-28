require('plugins').setup()
require('lsp').setup()
require('commands').setup()
require('options').setup()

local server = require('server')
server.start_apm_server()
