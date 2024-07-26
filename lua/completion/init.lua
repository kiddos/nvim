local M = {}

M.setup = function(opts)
  local config = require('completion.config')
  config.merge_option(opts)

  local completion = require('completion.completion')
  local signature = require('completion.signature')
  local info = require('completion.info')

  completion.setup()
  signature.setup()
  info.setup()

  -- options
  vim.api.nvim_set_option_value('completeopt', 'menuone,noinsert', {})
end

return M
