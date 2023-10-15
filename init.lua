--
--  Author: Joseph Yu
--

require('plugins')
require('plugin-settings').setup()
require('lsp').setup()

require('commands').setup()

require('options').apply()
local server = require('server')
server.start_apm_server()
-- server.start_codellama_code_server()
server.start_codellama_instruct_server()

require('treesitter-config').apply()
