local commands = {}
local context = {
  highlight_group = nil
}

local ALTERNATE_EXTENSIONS = {
  c = {'h'},
  cpp = {'h', 'hpp'},
  cc = {'h', 'hpp'},
  h = {'cpp', 'cc', 'c'},
  hpp = {'cpp', 'cc'},
  html = {'css'},
  css = {'html', 'js'},
  js = {'css'},
  jsx = {'css'},
  ts = {'html'},
}

commands.typo_command = function()
  vim.api.nvim_create_user_command('WQ', 'wq', {})
  vim.api.nvim_create_user_command('Wq', 'wq', {})
  vim.api.nvim_create_user_command('W', 'w', {})
  vim.api.nvim_create_user_command('Q', 'q', {})
  vim.api.nvim_create_user_command('Qa', 'qa', {})
  vim.api.nvim_create_user_command('QA', 'qa', {})
end

commands.semicolon = function()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = {
      'c',
      'cpp',
      'cuda',
      'arduino',
      'java',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'html',
      'css',
      'dart',

      'matlab',
      'php',
      'perl',
      'objc',
      'objcpp',
      'csharp',
    },
    command = 'nnoremap ; $a;',
  })
end

commands.compile = function()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = {'c', 'cpp'},
    command = 'command! Compile execute ":!clang++ % -Wall -std=c++17 -fsanitize=address -O1 -g -o %:r"',
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = {'cuda'},
    command = 'command! Compile execute ":!nvcc % -o %:r"',
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = {'java'},
    command = 'command! Compile execute ":!javac %"',
  })
end

commands.unhighlight_trailing_space = function()
  if context.highlight_group ~= nil then
    vim.fn.matchdelete(context.highlight_group)
  end
end

commands.highlight_trailing_space = function()
  context.highlight_group = vim.fn.matchadd('TrailingSpace', [[\v(\s+$)|( +\ze\t)]])
  -- context.highlight_group = vim.fn.matchadd('TrailingSpace', [[\s\+$]])
end

commands.trim_trailing_space = function()
  vim.cmd([[keeppatterns %s/\s\+$//e]])
end


commands.alternate_file = function()
  local current_path = vim.fn.expand('%:p')
  local current_extension = string.lower(vim.fn.fnamemodify(current_path, ':e'))
  local alternate_extensions = ALTERNATE_EXTENSIONS[current_extension]

  local function file_exists(filename)
    local stat = vim.loop.fs_stat(filename)
    return stat and stat.type or false
  end

  if not alternate_extensions or vim.tbl_isempty(alternate_extensions) then
    return
  end

  local function find_alternate_file()
    local filename = vim.fn.expand('%:p:r')
    for _, ext in pairs(alternate_extensions) do
      local alternate_file = filename .. '.' .. ext
      if file_exists(alternate_file) then
        return alternate_file
      end
    end
    return filename .. '.' .. alternate_extensions[1]
  end

  local alternate_file = find_alternate_file()
  vim.api.nvim_exec(':e ' .. alternate_file, false)
end


commands.setup = function()
  commands.typo_command()
  commands.semicolon()
  commands.compile()

  vim.api.nvim_exec('hi TrailingSpace guibg=#D70000 guibg=#D70000 ctermbg=160 ctermfg=160', true)
  vim.api.nvim_create_user_command('HighlightTrailingSpace', commands.highlight_trailing_space, {})
  vim.api.nvim_set_var('mapleader', ',')
  vim.api.nvim_set_keymap('n', '<Leader><Space><Space><Space>', '', {
    silent = true,
    noremap = true,
    callback = commands.highlight_trailing_space,
    desc = 'Highlight trailing space',
  })
  vim.api.nvim_create_user_command('TrimSpace', commands.trim_trailing_space, {})
  -- vim.defer_fn(commands.highlight_trailing_space, 100)

  vim.api.nvim_create_user_command('A', commands.alternate_file, {})
  vim.api.nvim_set_keymap('n', '<Leader><Leader>a', '', {
    silent = true,
    noremap = true,
    callback = commands.alternate_file,
    desc = 'Alternate file',
  })
end

return commands
