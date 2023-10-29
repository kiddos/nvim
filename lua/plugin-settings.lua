local settings = {}

settings.setup = function()
  -- color scheme
  vim.cmd.colorscheme('malokai')

  -- git
  vim.api.nvim_set_var('gitgutter_enabled', false)
  vim.api.nvim_set_keymap('n', '<F2>', ':GitGutterToggle<CR>', {noremap=true, silent=true})
  vim.api.nvim_set_keymap('i', '<F2>', '<Esc>:GitGutterToggle<CR>', {noremap=true, silent=true})

  vim.api.nvim_set_var('gitblame_enabled', false)
  vim.api.nvim_set_keymap('n', '<F3>', ':GitBlameToggle<CR>', {noremap=true, silent=true})
  vim.api.nvim_set_keymap('i', '<F3>', '<Esc>:GitBlameToggle<CR>', {noremap=true, silent=true})


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


  -- A
  vim.api.nvim_set_var('mapleader', ',')
  vim.api.nvim_set_keymap('n', '<Leader><Leader>a', ':A<CR>', {silent=true})


  -- emmet
  vim.api.nvim_set_var('user_emmet_togglecomment_key', '<C-y>#')

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

  local register_fzf_menu = function(fzf_command, menu)
    vim.api.nvim_command('nnoremenu FZF.' .. menu:gsub(' ', '\\ ') .. ' :' .. fzf_command .. '<CR>')
  end

  register_fzf_menu('GFiles', 'Git files 🦜')
  register_fzf_menu('Buffers', 'Open buffers 🦥')
  register_fzf_menu('Colors', 'Color scheme 🎨')
  register_fzf_menu('Ag', 'ag search 🦆')
  register_fzf_menu('Rg', 'rg search 🧸')
  register_fzf_menu('Lines', 'Find in loadded buffers 🦄🦄🦄')
  register_fzf_menu('Tags', 'Tags in the project 🦏')
  register_fzf_menu('Changes', 'Changelist across open buffers 🦅')
  register_fzf_menu('Marks', 'Marks 🦋')
  register_fzf_menu('Jumps', 'Jumps 🦗')
  register_fzf_menu('Windows', 'Windows ')
  register_fzf_menu('History', 'History 🐓')
  register_fzf_menu('Snippets', 'Snippets 🦭🦭🦭')
  register_fzf_menu('Commits', 'Git Commits 🦣🦣')
  register_fzf_menu('Commands', 'Commands 🦩')
  register_fzf_menu('Helptags', 'Help tags 🦎')
  register_fzf_menu('Filetypes', 'File types 🦘')

  vim.api.nvim_set_keymap('n', '<M-n>', '', {
    expr = true,
    noremap = true,
    silent = true,
    callback = function()
      if vim.fn.pumvisible() == 0 then
        vim.api.nvim_command('popup FZF')
      end
    end
  })


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
    y = 'APM: #(python3 ~/.config/nvim/scripts/apm_client.py) #(uptime  | cut -d " " -f 1,2)',
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

  -- snippy
  require('snippy').setup({
    mappings = {
      is = {
        ['<Tab>'] = 'expand_or_advance',
        -- ['<S-Tab>'] = 'previous',
      },
    },
  })

  -- wilder.nvim
  local wilder = require('wilder')
  wilder.setup({modes = {':', '/', '?'}})

  wilder.set_option('renderer', wilder.popupmenu_renderer({
    highlighter = wilder.basic_highlighter(),
    left = {' ', wilder.popupmenu_devicons()},
    right = {' ', wilder.popupmenu_scrollbar()},
  }))

  -- translate
  require('translate').setup()
end

return settings
