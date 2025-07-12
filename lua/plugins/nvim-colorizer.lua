local api = vim.api

local config = function()
  local colorizer = require('colorizer')
  colorizer.setup()

  api.nvim_set_keymap('n', '<F6>', '', {
    silent = true,
    noremap = true,
    callback = function()
      if colorizer.is_buffer_attached(0) then
        colorizer.detach_from_buffer(0)
        vim.notify('Disable nvim-colorizer', vim.log.levels.INFO, {})
      else
        colorizer.attach_to_buffer(0)
        vim.notify('Enable nvim-colorizer', vim.log.levels.INFO, {})
      end
    end
  })
end

return {
  'norcalli/nvim-colorizer.lua',
  keys = { '<F6>' },
  ft = { 'css', 'javascript', 'jsp', 'html' },
  config = config,
}
