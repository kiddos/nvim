local config = function()
  vim.api.nvim_set_var('gitgutter_enabled', false)
  local enabled = false
  local callback = function()
    if enabled then
      enabled = false
      vim.notify('Disable GitGutter 🥺', vim.log.levels.WARN)
      vim.api.nvim_command('GitGutterDisable')
    else
      enabled = true
      vim.notify('Enable GitGutter 🦈')
      vim.api.nvim_command('GitGutterEnable')
    end
  end
  vim.api.nvim_set_keymap('n', '<F2>', '', { noremap = true, silent = true, callback = callback })
  vim.api.nvim_set_keymap('i', '<F2>', '', { noremap = true, silent = true, callback = callback })
end

return {
  'airblade/vim-gitgutter',
  cmd = { 'GitGutterToggle' },
  keys = { '<F2>' },
  config = config,
}
