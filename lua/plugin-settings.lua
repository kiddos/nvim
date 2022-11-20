local settings = {}

settings.setup = function()
  -- barbar
  local bufferline = require('bufferline')
  bufferline.setup({
    animation = false,
    icon_custom_colors = true,
    maximum_padding = 2,
  })

  vim.api.nvim_set_keymap('n', '<A-,>', ':BufferPrevious<CR>', {silent=true, noremap=true})
  vim.api.nvim_set_keymap('n', '<A-.>', ':BufferNext<CR>', {silent=true, noremap=true})

  vim.api.nvim_set_var('mapleader', ',')
  -- Re-order to previous/next
  vim.api.nvim_set_keymap('n', '<A-Left>', ':BufferMovePrevious<CR>', {silent=true, noremap=true})
  vim.api.nvim_set_keymap('n', '<A-Right>', ':BufferMoveNext<CR>', {silent=true, noremap=true})

  for i = 1,9,1 do
    vim.api.nvim_set_keymap('n', string.format('<Leader>%d', i), string.format(':BufferGoto %d<CR>', i), {silent=true, noremap=true})
  end

  -- Goto buffer in position...
  vim.api.nvim_set_keymap('n', '<Leader>0', ':BufferLast<CR>', {silent=true, noremap=true})
  -- Close buffer
  vim.api.nvim_set_keymap('n', '<Leader><Leader>c', ':BufferClose<CR>', {silent=true, noremap=true})
  vim.api.nvim_set_keymap('n', '<Leader><Leader><Space>', ':BufferCloseAllButCurrent<CR>', {silent=true, noremap=true})
  vim.api.nvim_set_keymap('n', '<Leader><Leader>s', ':BufferPick<CR>', {silent=true, noremap=true})

  -- Wipeout buffer
  -- :BufferWipeout<CR>
  -- Close commands
  -- :BufferCloseAllButCurrent<CR>
  -- :BufferCloseBuffersLeft<CR>
  -- :BufferCloseBuffersRight<CR>
  -- Magic buffer-picking mode nnoremap <silent> <C-s>    :BufferPick<CR>
  -- Sort automatically by...
  -- nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
  -- nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>

  -- git
  vim.api.nvim_set_var('gitgutter_enabled', false)
  vim.api.nvim_set_keymap('n', '<F2>', ':GitGutterToggle<CR>', {noremap=true, silent=true})
  vim.api.nvim_set_keymap('i', '<F2>', '<Esc>:GitGutterToggle<CR>', {noremap=true, silent=true})

  vim.api.nvim_set_var('gitblame_enabled', false)
  vim.api.nvim_set_keymap('n', '<F3>', ':GitBlameToggle<CR>', {noremap=true, silent=true})
  vim.api.nvim_set_keymap('i', '<F3>', '<Esc>:GitBlameToggle<CR>', {noremap=true, silent=true})

  require('git-conflict').setup()


  -- NerdTree
  vim.api.nvim_set_var('NERDSpaceDelims', true)
  vim.api.nvim_set_var('NERDCompactSexyComs', true)
  vim.api.nvim_set_var('NERDDefaultAlign', 'left')
  vim.api.nvim_set_var('NERDCustomDelimiters ', {
    c = {left='//'},
    arduino = {left='//'},
    vim = {left='"'},
    conf = {left='#'},
    prototxt = {left='#'}
  })
  vim.api.nvim_set_keymap('n', '<F1>', ':NERDTreeToggle .<CR>', {noremap=true, silent=true})
  vim.api.nvim_set_keymap('i', '<F1>', '<Esc>:NERDTreeToggle .<CR>', {noremap=true, silent=true})

  -- nvim-tree
  require("nvim-tree").setup()
  vim.api.nvim_set_keymap('n', '<F5>', ':NvimTreeToggle<CR>', {noremap=true, silent=true})
  vim.api.nvim_set_keymap('i', '<F5>', '<Esc>:NvimTreeToggle<CR>', {noremap=true, silent=true})

  -- A
  vim.api.nvim_set_var('mapleader', ',')
  vim.api.nvim_set_keymap('n', '<Leader><Leader>a', ':A<CR>', {silent=true})


  -- emmet
  vim.api.nvim_set_var('user_emmet_togglecomment_key', '<C-y>#')


  -- flutter
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = false
  require('flutter-tools').setup({
    lsp = {
      capabilities = capabilities,
    }
  })


  -- fzf
  local rg_options = {
    '--column',
    '--line-number',
    '--with-filename',
    '--color=always',
    '--smart-case ',
    '--no-search-zip',
    '-g \'!{**/node_modules,**/.git}\'',
  }
  local rg_command = 'rg ' .. table.concat(rg_options, ' ') .. ' -- '
  vim.api.nvim_create_user_command('Rg', 'call fzf#vim#grep("' .. rg_command .. '".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)', {})
  vim.api.nvim_set_keymap('n', '<C-P>', ':Files<CR>', {noremap=true, silent=true})


  -- vim-startify
  vim.api.nvim_set_var('startify_list_order', {
    {'    Recently used files in current directory:'}, 'dir',
    {'    Recently used files:'}, 'files',
    {'    Bookmarks:'}, 'bookmarks',
    {'    Sessions:'}, 'sessions',
  })
  vim.api.nvim_set_var('startify_files_number', 3)
  vim.g.startify_bookmarks = {
    {vimrc = '~/.vim/vimrc'},
    {nvimrc = '~/.config/nvim/init.lua'}
  }
  -- vim.g.startify_custom_header = vim.api.nvim_eval("map(split(system('fortune | cowsay -f $(ls /usr/share/cowsay/cows | shuf -n 1 | cut -d. -f1)'), '\n'), '"   ". v:val') + ['']")
  vim.g.startify_custom_header = vim.api.nvim_eval("split(system('fortune | cowsay -f $(ls /usr/share/cowsay/cows | shuf -n 1 | cut -d. -f1)'), '\n')")
  vim.g.startify_change_to_dir = 1
  vim.g.startify_change_to_vcs_root = 1
  vim.g.startify_enable_special = 0


  -- tmuxline with vim-airline
  vim.api.nvim_set_var('airline_theme', 'onedark')
  vim.api.nvim_set_var('airline_disable_statusline', 1)
  vim.api.nvim_set_var('airline_detect_modified', 1)
  vim.api.nvim_set_var('airline_detect_paste', 1)
  vim.api.nvim_set_var('airline_detect_crypt', 1)
  vim.api.nvim_set_var('airline_detect_iminsert', 1)
  vim.api.nvim_set_var('airline_inactive_collapse', 1)
  vim.api.nvim_set_var('airline_powerline_fonts', 1)

  vim.api.nvim_set_var('airline_symbols', {
    crypt = '🔒',
    linenr = '🔭',
    maxlinenr = '🔬',
    -- branch = '🛠 ',
    branch = '🔀',
    paste = '📑',
    readonly = '⛔️',
    spell = 'Ꞩ',
    whitespace = '🕳 ',
    notexists = '🛑',
  })

  -- vim.g.airline_left_sep = '⌨️ '
  -- vim.g.airline_right_sep = '💻'
  -- vim.g.airline_right_alt_sep = '💠'
  -- vim.g.airline_left_alt_sep = '🛸'

  -- airline-branch
  -- vim.g['airline#extensions#branch#enabled'] = 1

  -- airline-ale
  -- vim.g['airline#extensions#ale#enabled'] = 1
  -- vim.g['airline#extensions#ale#error_symbol'] = '🚫'
  -- vim.g['airline#extensions#ale#warning_symbol'] = '⚠️ '

  -- airline-tabline
  -- vim.g['airline#extensions#tabline#enabled'] = 1
  -- vim.g['airline#extensions#tabline#show_splits'] = 0
  -- vim.g['airline#extensions#tabline#show_tab_count'] = 0
  -- vim.g['airline#extensions#tabline#show_buffers'] = 0
  -- vim.g['airline#extensions#tabline#show_tab_nr'] = 0
  -- vim.g['airline#extensions#tabline#overflow_marker ='] '…'
  -- vim.g['airline#extensions#tabline#current_first'] = 0
  -- vim.g['airline#extensions#tabline#tabs_label'] = ''
  -- vim.g['airline#extensions#tabline#fnamemod'] = ':t'
  -- vim.g['airline#extensions#tabline#fnamecollapse'] = 0
  -- vim.g['airline#extensions#tabline#show_close_button'] = 0
  -- vim.g['airline#extensions#tabline#exclude_preview'] = 0
  -- vim.g['airline#extensions#tabline#buffer_nr_show'] = 0
  -- vim.g['airline#extensions#tabline#show_tab_type'] = 0

  -- airline-nvimlsp
  -- vim.g['airline#extensions#nvimlsp#enabled'] = 1
  -- vim.g['airline#extensions#nvimlsp#error_symbol'] = '🚫'
  -- vim.g['airline#extensions#nvimlsp#warning_symbol'] = '⚠️ '

  vim.api.nvim_set_var('tmuxline_preset', {
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
  })
  vim.api.nvim_set_var('tmuxline_separators', {
    left = '◗',
    left_alt = '◗',
    right = '◖',
    right_alt = '◖',
    space = ' '
  })

  -- neosnippets
  vim.api.nvim_set_var('neosnippet#enable_snipmate_compatibility', 1)
  vim.api.nvim_set_var('neosnippet#enable_completed_snippet', 1)
  
  vim.api.nvim_set_keymap('i', '<Tab>', 'neosnippet#expandable_or_jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"', {expr=true, silent=true})
  vim.api.nvim_set_keymap('s', '<Tab>', 'neosnippet#expandable_or_jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"', {expr=true, silent=true})


  -- clang-format
  vim.api.nvim_set_var('clang_format#code_style', 'google')
  vim.api.nvim_set_var('clang_format#filetype_style_options', {
    cpp = {
      ['Standard'] = 'C++17',
      ['ColumnLimit'] = 80,
    },
    javascript = {
      ['ColumnLimit'] = 80,
    },
  })


  -- vim-autopep8
  vim.api.nvim_set_var('autopep8_indent_size', 2)
  vim.api.nvim_set_var('autopep8_disable_show_diff', 0)
  vim.api.nvim_set_var('autopep8_max_line_length', 80)
  -- vim.g.autopep8_ignore="W291,W391,E111,E113,E114,E121,E125,E127,E128,E221,E225,E226,E231,E302,E303,W391,E501,E701,F401"


  -- wilder.nvim
  local wilder = require('wilder')
  wilder.setup({modes = {':', '/', '?'}})

  wilder.set_option('renderer', wilder.popupmenu_renderer({
    highlighter = wilder.basic_highlighter(),
    left = {' ', wilder.popupmenu_devicons()},
    right = {' ', wilder.popupmenu_scrollbar()},
  }))


  -- marks
  local marks = require('marks')
  marks.setup()
  vim.api.nvim_set_keymap('n', '<Leader>dm', ':delmarks a-zA-Z0-9<CR>', {silent=true, noremap=true})
end

return settings
