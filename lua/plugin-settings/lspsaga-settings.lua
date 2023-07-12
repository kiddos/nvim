local M = {}

M.setup = function()
  local saga = require('lspsaga')
  saga.setup({
    request_timeout = 16000,
    ui = {
      border = 'rounded',
      winblend = 0,
      expand = '⊞',
      collapse = '⊟',
      preview = '🖵  ',
      code_action = '💡',
      diagnostic = '🐞',
      incoming = '➡',
      outgoing = '⬅',
    },
    lightbulb = {
      enable = true,
      sign = true,
      sign_priority = 100,
      debounce = 2000,
      virtual_text = false,
    },
    symbol_in_winbar = {
      enable = false,
      separator = ' ',
      hide_keyword = true,
      show_file = true,
      folder_level = 2,
      respect_root = false,
      color_mode = false,
    },
  })

  vim.api.nvim_set_var('mapleader', ',')
  vim.api.nvim_set_keymap('n', '<Leader>find', '', {
    noremap = true,
    silent = true,
    callback = function()
      vim.api.nvim_command('Lspsaga finder')
    end
  })

  vim.api.nvim_set_keymap('n', '<Leader>code', '', {
    noremap=true,
    silent=true,
    callback = function()
      vim.api.nvim_command('Lspsaga code_action')
    end
  })

  vim.api.nvim_set_keymap('v', '<Leader>code', '', { noremap=true, silent=true,
    callback = function()
      vim.api.nvim_command('Lspsaga code_action')
    end
  })

  vim.api.nvim_set_keymap('n', '<Leader>rename', '', {
    noremap = true,
    silent = true,
    callback = function()
      vim.api.nvim_command('Lspsaga rename')
    end
  })

  vim.api.nvim_set_keymap('n', '<Leader><Leader>r', '', {
    noremap = true,
    silent = true,
    callback = function()
      vim.api.nvim_command('Lspsaga rename')
    end
  })

  vim.api.nvim_set_keymap('n', '<Leader>imp', '', {
    noremap = true,
    silent = true,
    callback = function()
      vim.api.nvim_command('Lspsaga finder imp')
    end
  })

  vim.api.nvim_set_keymap('n', '<Leader><Leader>i', '', {
    noremap = true,
    silent = true,
    callback = function()
      vim.api.nvim_command('Lspsaga finder imp')
    end
  })

  vim.api.nvim_set_keymap('n', '<Leader>doc', '', {
    noremap = true,
    silent = true,
    callback = function()
      vim.api.nvim_command('Lspsaga peek_definition')
    end
  })

  vim.api.nvim_set_keymap('n', '<Leader>diag', '', {
    noremap = true,
    silent = true,
    callback = function()
      vim.api.nvim_command('Lspsaga show_cursor_diagnostics')
    end
  })

  vim.api.nvim_set_keymap('n', '<Leader>hover', '', {
    noremap = true,
    silent = true,
    callback = function()
      vim.api.nvim_command('Lspsaga hover_doc')
    end
  })
end

return M
