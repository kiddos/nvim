-- completion setting
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  throttle_time = 60;
  source_timeout = 300;
  resolve_timeout = 600;
  incomplete_delay = 600;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  source = {
    path = true;
    buffer = {
      ignored_filetypes = {'json', 'text', ''}
    };
    calc = false;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
    ultisnips = false;
    luasnip = false;
  };
}

vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', {expr = true, noremap = true})
vim.api.nvim_set_keymap('i', '<CR>', 'compe#confirm({"keys": "\\<Plug>delimitMateCR", "mode": ""})', {expr = true, noremap = true})

-- status line setting
require('lualine').setup{
  options = {
    theme = 'onedark',
    section_separators = {'◗', '◖'},
    component_separators = {'►', '◄'}
  },
}

-- treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  indent = {
    enable = false
  },
  highlight = {
    enable = true,
    disable = {'javascript', 'css', 'vim'},
    additional_vim_regex_highlighting = false
  },
}

-- tmux line
vim.g.tmuxline_preset = {
  a = '#S',
  b = '#W',
  c = '',
  win = '#I #W',
  cwin = '#I #W',
  y = 'APM: #(python3 ~/.config/nvim/apm_client.py) #(uptime  | cut -d " " -f 1,2)',
  z = '#(whoami)@#H',
  options = {
    ['status-justify'] = 'left'
  }
}
vim.g.tmuxline_separators = {
  left = '◗',
  left_alt = '◗',
  right = '◖',
  right_alt = '◖',
  space = ' '
}

vim.g['clang_format#code_style'] = 'google'
vim.g['clang_format#filetype_style_options'] = {
  cpp = {
    ['Standard'] = 'C++11',
    ['ColumnLimit'] = 80,
  },
  javascript = {
    ['ColumnLimit'] = 80,
  },
}

-- autopep setting
vim.g.autopep8_indent_size = 2
vim.g.autopep8_disable_show_diff = 0
vim.g.autopep8_max_line_length = 80
-- vim.g.autopep8_ignore="W291,W391,E111,E113,E114,E121,E125,E127,E128,E221,E225,E226,E231,E302,E303,W391,E501,E701,F401"

-- jsx-pretty setting
vim.g.vim_jsx_pretty_enable_jsx_highlight = 0

-- airline + tmuxline
vim.g.airline_theme = 'onedark'
