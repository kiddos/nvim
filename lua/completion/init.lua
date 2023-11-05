local M = {}

local config = require('completion.config')
local completion = require('completion.completion')
local signature = require('completion.signature')
local info = require('completion.info')

M.apply_options = function(opts)
  opts = opts or {}
  if opts.cr_mapping ~= nil then
    config.completion.cr_mapping = opts.cr_mapping
  end
end

M.setup = function(opts)
  M.apply_options(opts)

  completion.setup()
  signature.setup()
  info.setup()

  -- options
  vim.api.nvim_set_option_value('completeopt', 'menuone,noinsert', {})
  -- vim.api.nvim_set_option_value('completeopt', 'menuone,noselect')
  -- maximum number of items to show in the popup menu
  vim.api.nvim_set_option_value('pumheight', 30, {})
  -- keyword completion
  vim.api.nvim_set_option_value('complete', '.,w,b,u,U,t,k', {})
  -- do not show XXX completion (YYY)
  vim.api.nvim_set_option_value('shortmess', vim.api.nvim_get_option_value('shortmess', {}) .. 'c', {})

  -- vim.api.nvim_create_user_command('CompletionToggle', function()
  --   context.completion.enabled = not context.completion.enabled
  -- end, {})
end

return M
