--
--  Author: Joseph Yu
--

require('plugins')
require('plugin-settings').setup()
require('lsp').setup()

require('commands').setup()

require('options').apply()
require('apm_server')

require('treesitter-config').apply()
