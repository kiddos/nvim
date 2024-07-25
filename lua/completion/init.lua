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
  -- -- vim.api.nvim_set_option_value('completeopt', 'menuone,noselect')
  -- -- maximum number of items to show in the popup menu
  -- vim.api.nvim_set_option_value('pumheight', 30, {})
  -- -- keyword completion
  -- vim.api.nvim_set_option_value('complete', '.,w,b,u,U,t,k', {})
  -- -- do not show XXX completion (YYY)
  -- vim.api.nvim_set_option_value('shortmess', vim.api.nvim_get_option_value('shortmess', {}) .. 'c', {})
end

return M
