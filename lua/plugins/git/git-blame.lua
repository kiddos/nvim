local config = function()
  vim.api.nvim_set_var('gitblame_enabled', false)
  local enabled = false
  local callback = function()
    if enabled then
      enabled = false
      vim.notify('Disable GitBlame 🥺', vim.log.levels.WARN)
      vim.api.nvim_command('GitBlameDisable')
    else
      enabled = true
      vim.notify('Enable GitBlame 🤨')
      vim.api.nvim_command('GitBlameEnable')
    end
  end
  vim.api.nvim_set_keymap('n', '<F3>', '', { noremap = true, silent = true, callback = callback })
  vim.api.nvim_set_keymap('i', '<F3>', '', { noremap = true, silent = true, callback = callback })
end

return {
  'f-person/git-blame.nvim',
  cmd = { 'GitBlameToggle', 'GitBlameEnable', 'GitBlameDisable', 'GitBlameOpenFileURL' },
  keys = { '<F3>' },
  config = config,
}
