local api = vim.api

local config = function()
  api.nvim_set_var('gitblame_enabled', false)
  local enabled = false
  local callback = function()
    if enabled then
      enabled = false
      vim.notify('🛑 Disable GitBlame', vim.log.levels.WARN)
      api.nvim_command('GitBlameDisable')
    else
      enabled = true
      vim.notify('✅ Enable GitBlame 🤨')
      api.nvim_command('GitBlameEnable')
    end
  end

  local opts = { noremap = true, silent = true, callback = callback }
  api.nvim_set_keymap('n', '<F3>', '', opts)
  api.nvim_set_keymap('i', '<F3>', '', opts)
  api.nvim_set_keymap('s', '<F3>', '', opts)
end

return {
  'f-person/git-blame.nvim',
  cmd = { 'GitBlameToggle', 'GitBlameEnable', 'GitBlameDisable', 'GitBlameOpenFileURL' },
  keys = { '<F3>' },
  config = config,
}
