--
--  Author: Joseph Yu
--

require('plugins')
require('plugin-settings').setup()
require('treesitter-config').apply()
require('lsp').setup()

require('commands').setup()

require('options').apply()
require('apm_server')
