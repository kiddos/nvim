local api = vim.api

local context = {
  highlight_group = nil
}

local toggle_highlight_trailing_space = function()
  local opts = {
    title = 'Highlight Trailing space',
    timeout = 300,
  }
  if context.highlight_group ~= nil then
    vim.fn.matchdelete(context.highlight_group)
    vim.notify('🛑 Disable highlight trailing space', vim.log.levels.INFO, opts)
    context.highlight_group = nil
  else
    context.highlight_group = vim.fn.matchadd('TrailingSpace', [[\v(\s+$)|( +\ze\t)]])
    -- context.highlight_group = vim.fn.matchadd('TrailingSpace', [[\s\+$]])
    vim.notify('✅ Highlight trailing space', vim.log.levels.INFO, opts)
  end
end

local trim_trailing_space = function()
  vim.cmd([[keeppatterns %s/\s\+$//e]])
end

api.nvim_set_hl(0, 'TrailingSpace', {
  bg = '#864F4F',
  fg = '#864F4F',
  ctermfg = 160,
  ctermbg = 160,
})

api.nvim_create_user_command('HighlightTrailingSpace', toggle_highlight_trailing_space, {})
api.nvim_set_var('mapleader', ',')
api.nvim_set_keymap('n', '<F4>', '', {
  silent = true,
  noremap = true,
  callback = toggle_highlight_trailing_space,
  desc = 'Highlight trailing space',
})
api.nvim_create_user_command('TrimSpace', trim_trailing_space, {})
