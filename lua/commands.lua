local commands = {}
local context = {
  highlight_group = nil
}

local ALTERNATE_EXTENSIONS = {
  c = { 'h' },
  cpp = { 'h', 'hpp' },
  cc = { 'h', 'hpp' },
  h = { 'cpp', 'cc', 'c' },
  hpp = { 'cpp', 'cc' },
  html = { 'css' },
  css = { 'html', 'js' },
  js = { 'css' },
  jsx = { 'css' },
  ts = { 'html' },
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
      'css',
      'dart',
      'rust',

      'matlab',
      'php',
      'objc',
      'objcpp',
    },
    callback = function()
      vim.api.nvim_buf_set_keymap(0, 'n', ';', '$a;', { noremap = true });
    end,
  })
end

commands.compile = function()
  local register_command = function(filetype, command)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetype,
      callback = function()
        local current = vim.api.nvim_get_current_buf()

        vim.api.nvim_buf_create_user_command(current, 'Compile', command, {
          force = true,
          desc = 'compile code',
        })

        vim.api.nvim_buf_set_keymap(current, 'n', '<C-F9>', '', {
          silent = true,
          noremap = true,
          desc = 'compile code',
          callback = function()
            vim.api.nvim_command(command)
          end
        })
      end,
    })
  end

  register_command({ 'c', 'cpp' }, '!clang++ % -Wall -Wextra -std=c++20 -fsanitize=address -O1 -g -o %:r')
  register_command({ 'rust' }, '!rustc %')
  register_command({ 'cuda' }, '!nvcc % -o %:r &')
  register_command({ 'java' }, '!javac % &')
  register_command({ 'dart' }, '!flutter test')
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
    local stat = vim.uv.fs_stat(filename)
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
  vim.api.nvim_command(':e ' .. alternate_file)
end

commands.reattach_current_buf_lsp = function()
  -- re-attach lsp servers
  local current_buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = current_buf })
  for _, client in pairs(clients) do
    vim.lsp.buf_detach_client(current_buf, client.id)
    vim.lsp.buf_attach_client(current_buf, client.id)
  end
end

-- linux commands binding
commands.rename = function(opts)
  local name = opts.args

  local current_filename = vim.fn.expand('%:t')
  if current_filename == name then
    return
  end

  local current_path = vim.fn.expand('%:p')
  local current_dir = vim.fn.expand('%:h')
  local input_dir = vim.fn.fnamemodify(name, ':h')

  local dirname = current_dir
  if input_dir ~= '' then
    dirname = dirname .. '/' .. input_dir
  end
  local filename = vim.fn.fnamemodify(name, ':t')
  vim.fn.mkdir(dirname, 'p')
  vim.api.nvim_command('file ' .. dirname .. '/' .. filename)
  vim.api.nvim_command('write!')
  vim.fn.delete(current_path)

  commands.reattach_current_buf_lsp()
  vim.api.nvim_command('redraw')

  print('🦉🦉🦉  Rename file to ' .. name)
end

commands.move = function(opts)
  local current_path = vim.fn.expand('%:p')
  local dirname = opts.args
  local filename = vim.fn.expand('%:t')
  vim.fn.mkdir(dirname, 'p')
  vim.api.nvim_command('file ' .. dirname .. '/' .. filename)
  vim.api.nvim_command('write!')
  vim.fn.delete(current_path)

  commands.reattach_current_buf_lsp()
  vim.api.nvim_command('redraw')

  print('🦫🦫🦫 Move file to ' .. dirname)
end

commands.remove = function()
  local current_path = vim.fn.expand('%:p')
  local result = vim.fn.confirm('Remove the file (' .. current_path .. ') ?', '&Yes\n&No', 1)
  if result == 1 then
    local current_buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = current_buf })
    for _, client in pairs(clients) do
      vim.lsp.buf_detach_client(current_buf, client.id)
    end

    vim.api.nvim_command('BufferClose')
    vim.fn.delete(current_path)
    vim.api.nvim_command('redraw')
    print('🦨🦨🦨 File (' .. current_path .. ') deleted.')
  end
end

commands.mkdir = function(opts)
  local dirname = opts.args
  vim.fn.mkdir(dirname, 'p')
  vim.api.nvim_command('redraw')
  print('🦭🦭🦭 Directory created : ' .. dirname)
end

commands.chmod = function(opts)
  local current_path = vim.fn.expand('%:p')
  local args = opts.args

  local function file_exists(filename)
    local stat = vim.uv.fs_stat(filename)
    return stat and stat.type or false
  end

  if file_exists(current_path) then
    vim.api.nvim_command('!chmod ' .. args .. ' ' .. current_path)
    vim.api.nvim_command('redraw')
  end
end


commands.setup = function()
  commands.typo_command()
  commands.semicolon()
  commands.compile()

  vim.api.nvim_command('hi TrailingSpace guibg=#D70000 guibg=#D70000 ctermbg=160 ctermfg=160')
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

  local refresh_nerdtree = function()
    if vim.fn.exists(':NERDTreeRefreshRoot') == 1 then
      vim.api.nvim_command('NERDTreeRefreshRoot')
    end
  end

  vim.api.nvim_create_user_command('Rename',
    function(opts)
      commands.rename(opts)
      refresh_nerdtree()
    end, { nargs = 1, complete = 'buffer' })

  vim.api.nvim_create_user_command('Move',
    function(opts)
      commands.move(opts)
      refresh_nerdtree()
    end, { nargs = 1, complete = 'file' })

  vim.api.nvim_create_user_command('Remove',
    function()
      commands.remove()
      refresh_nerdtree()
    end, {})

  vim.api.nvim_create_user_command('Mkdir',
    function(opts)
      commands.mkdir(opts)
      refresh_nerdtree()
    end, { nargs = 1, complete = 'file' })

  vim.api.nvim_create_user_command('Chmod',
    function(opts)
      commands.chmod(opts)
      refresh_nerdtree()
    end, {
      nargs = 1,
      complete = function()
        return { '+x', '777', '664' }
      end
    })

  vim.api.nvim_create_user_command('SqlFormat',
    function()
      vim.api.nvim_command('%!sqlformat --reindent --keywords upper --identifiers lower -')
    end, {})

  vim.api.nvim_create_user_command('CountLines', function()
    vim.api.nvim_command('!git ls-files | xargs wc -l')
  end, {})
end

return commands
