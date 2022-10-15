--
--  Author: Joseph Yu
--

require('commands').setup()

require('plugins')
require('plugin-settings').setup()
require('treesitter-config').apply()
require('lsp').setup()

require('options').apply()
require('apm_server')
