local M = {}

M.setup = function()
  local saga = require('lspsaga')
  saga.setup({
    request_timeout = 16000,
    ui = {
      border = 'rounded',
      winblend = 0,
      expand = '',
      collapse = '',
      preview = '🖵  ',
      code_action = '💡',
      diagnostic = '🐞',
      incoming = ' ',
      outgoing = ' ',
    },
    lightbulb = {
      enable = true,
      enable_in_insert = false,
      sign = true,
      sign_priority = 40,
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
      vim.api.nvim_command('Lspsaga lsp_finder')
    end
  })

  vim.api.nvim_set_keymap('n', '<Leader>code', '', {
    noremap=true,
    silent=true,
    callback = function()
      vim.api.nvim_command('Lspsaga code_action')
    end
  })

  vim.api.nvim_set_keymap('v', '<Leader>code', '', {
    noremap=true,
    silent=true,
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

  vim.api.nvim_set_keymap('n', '<A-d>', '', {
    noremap = true,
    silent = true,
    callback = function()
      vim.api.nvim_command('Lspsaga open_floaterm')
    end
  })

  vim.api.nvim_set_keymap('t', '<A-d>', '', {
    noremap = true,
    silent = true,
    callback = function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true), 'n', false)
      vim.api.nvim_command('Lspsaga close_floaterm')
    end
  })
end

return M
