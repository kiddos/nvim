local settings = {}

settings.setup = function()
  -- color scheme
  vim.cmd.colorscheme('malokai')
  vim.api.nvim_set_option_value('termguicolors', true, {})

  require('colorizer').setup()

  -- git
  vim.api.nvim_set_var('gitgutter_enabled', false)
  vim.api.nvim_set_keymap('n', '<F2>', ':GitGutterToggle<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('i', '<F2>', '<Esc>:GitGutterToggle<CR>', { noremap = true, silent = true })

  vim.api.nvim_set_var('gitblame_enabled', false)
  vim.api.nvim_set_keymap('n', '<F3>', ':GitBlameToggle<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('i', '<F3>', '<Esc>:GitBlameToggle<CR>', { noremap = true, silent = true })

  require("nvim-tree").setup()
  local tree_api = require('nvim-tree.api').tree
  local modes = { 'n', 'i' }
  for _, mode in pairs(modes) do
    vim.api.nvim_set_keymap(mode, '<F1>', '', {
      noremap = true,
      silent = true,
      callback = function()
        tree_api.toggle()
      end
    })
  end


  require('nvim-surround').setup({})

  -- A
  vim.api.nvim_set_var('mapleader', ',')
  vim.api.nvim_set_keymap('n', '<Leader><Leader>a', ':A<CR>', { silent = true })


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
  vim.api.nvim_create_user_command('Rg',
    'call fzf#vim#grep("' .. rg_command .. '".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)', {})
  vim.api.nvim_set_keymap('n', '<C-P>', ':Files<CR>', { noremap = true, silent = true })

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
  register_fzf_menu('Snippets', 'Snippets')
  register_fzf_menu('Commits', 'Git Commits')
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
  wilder.setup({ modes = { ':', '/', '?' } })

  wilder.set_option('renderer', wilder.popupmenu_renderer({
    highlighter = wilder.basic_highlighter(),
    left = { ' ', wilder.popupmenu_devicons() },
    right = { ' ', wilder.popupmenu_scrollbar() },
  }))

  -- translate
  require('translate').setup()

  local notify = require('notify')
  notify.setup({
    max_width = 60,
    timeout = 1000,
  })
  vim.notify = notify

  require('gen').setup({
    model = 'mistral:cpu',
    init = function(_) end,
    show_model = true,
    prompts = {
      Summarize = { prompt = 'What does the following code do?\n```$filetype\n$text\n```\n' },
      Unit_Test = { prompt = 'Write unit test for the following code\n```$filetype\n$text\n```\n' },
      Review_Code = { prompt = 'Review the following code and make concise suggestions:\n```$filetype\n$text\n```', },
      Enhance_Code = {
        prompt =
        "Enhance the following code, only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```",
      },
      Change_Code = {
        prompt =
        "Regarding the following code, $input, only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```",
      },
    }
  })
end

return settings
