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
      enable = false,
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

  -- vim.cmd('aunmenu LspSaga')
  vim.api.nvim_set_var('mapleader', ',')

  local register_command = function(saga_command, binding, command, menu)
    if binding and binding ~= '' then
      vim.api.nvim_set_keymap('n', binding, '', {
        noremap = true,
        silent = true,
        callback = function()
          vim.api.nvim_command(saga_command)
        end
      })
    end
    vim.api.nvim_create_user_command(command, function()
      vim.defer_fn(function()
        vim.api.nvim_command(saga_command)
      end, 0)
    end, {})

    vim.api.nvim_command('nnoremenu LSP.' .. menu:gsub(' ', '\\ ') .. ' :' .. command .. '<CR>')
  end

  register_command('Lspsaga hover_doc', nil, 'HoverDoc', 'Hover ✨')
  register_command('Lspsaga code_action', nil, 'Code', 'Code Action ⚡⚡⚡')
  register_command('Lspsaga rename', '<Leader>rename', 'RenameSymbol', 'Rename ✍ ')
  register_command('Lspsaga show_cursor_diagnostics', nil, 'CurrentDiagnostics', 'Cursor Diagnostic 💩')
  register_command('Lspsaga finder imp', nil, 'GotoImplementation', 'Goto Implementation 🐻')
  register_command('Lspsaga goto_definition', nil, 'GotoDefinition', 'Goto Definition 🐣')
  register_command('Lspsaga goto_type_definition', nil, 'GotoTypeDefinition', 'Goto Type Definition 🐥')
  register_command('Lspsaga peek_definition', nil, 'PeekDefinition', 'Peek Definition 🐦')
  register_command('Lspsaga incoming_calls', nil, 'IncomingCall', 'Incoming Call 🐉')
  register_command('Lspsaga outgoing_calls', nil, 'OutgoingCall', 'Outgoing Call 🐬')
  register_command('Lspsaga term_toggle', nil, 'OpenTerminal', 'Open Terminal 🌌 ')
  register_command('Lspsaga finder', nil, 'Finder', 'Finder ⭐ ')

  local register_popup_keymap = function(key)
    vim.api.nvim_set_keymap('n', key, '', {
      expr = true,
      noremap = true,
      silent = true,
      callback = function()
        if vim.fn.pumvisible() == 0 then
          vim.api.nvim_command('popup LSP')
        end
      end
    })
  end

  register_popup_keymap('<C-n>')
  -- register_popup_keymap('<C-Space>')


  local register_toggle_key = function(key, command)
    vim.api.nvim_set_keymap('n', key, '', {
      expr = true,
      noremap = true,
      silent = true,
      callback = function()
        vim.api.nvim_command('Lspsaga ' .. command)
      end
    })
  end

  register_toggle_key('<F4>', 'outline')
  register_toggle_key('<F5>', 'winbar_toggle')
end

return M
