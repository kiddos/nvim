local api = vim.api

local config = function()
  api.nvim_set_var('gitgutter_enabled', false)
  local enabled = false
  local callback = function()
    if enabled then
      enabled = false
      vim.notify('🛑 Disable GitGutter', vim.log.levels.WARN)
      api.nvim_command('GitGutterDisable')
    else
      enabled = true
      vim.notify('✅ GitGutter')
      api.nvim_command('GitGutterEnable')
    end
  end
  local opts = { noremap = true, silent = true, callback = callback }
  api.nvim_set_keymap('n', '<F2>', '', opts)
  api.nvim_set_keymap('i', '<F2>', '', opts)
end

return {
  'airblade/vim-gitgutter',
  cmd = { 'GitGutterToggle', 'GitGutterEnable', 'GitGutterDisable' },
  keys = { '<F2>' },
  config = config,
}
