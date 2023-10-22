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

commands.detach_current_buf_lsp = function()
  local current_buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = current_buf })
  for _, client in pairs(clients) do
    vim.lsp.buf_detach_client(current_buf, client.id)
    vim.lsp.buf_attach_client(current_buf, client.id)
  end
  return clients
end

commands.attach_current_buf_lsp = function(clients)
  local current_buf = vim.api.nvim_get_current_buf()
  for _, client in pairs(clients) do
    vim.lsp.buf_attach_client(current_buf, client.id)
  end
end

commands.table_get = function (t, id)
  if type(id) ~= 'table' then return commands.table_get(t, { id }) end
  local success, res = true, t
  for _, i in ipairs(id) do
    success, res = pcall(function() return res[i] end)
    if not success or res == nil then return end
  end
  return res
end


commands.debug = function(o, ind)
  if type(o) == 'table' then
    local s = '{\n'
    for i = 1,ind do
      s = s .. ' '
    end
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. commands.debug(v, ind+1) .. ','
    end
    s = s .. '\n'
    return s .. '}\n'
  else
    return tostring(o)
  end
end

commands.find_client_with_supported_method = function(method)
  local buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = buf })
  if vim.tbl_isempty(clients) then
    return nil
  end

  for _, c in pairs(clients) do
    if c.supports_method(method) then
      return c
    end
  end
  return nil
end

-- linux commands binding
commands.rename = function(new_filename)
  local current_filename = vim.fn.expand('%:t')
  if current_filename == new_filename then
    return
  end

  -- local clients = commands.detach_current_buf_lsp()

  -- create directory
  local input_dir = vim.fn.fnamemodify(new_filename, ':h')
  local current_dir = vim.fn.expand('%:h')
  local dirname = current_dir
  if input_dir ~= '' then
    dirname = dirname .. '/' .. input_dir
  end
  vim.fn.mkdir(dirname, 'p')

  -- move the file
  local filename = vim.fn.fnamemodify(new_filename, ':t')
  vim.api.nvim_command('file ' .. dirname .. '/' .. filename)
  vim.api.nvim_command('write!')

  -- delete the old file
  local current_path = vim.fn.expand('%:p')
  vim.fn.delete(current_path)

  -- commands.attach_current_buf_lsp(clients)
  vim.api.nvim_command('redraw')

  print('🦉🦉🦉  Rename file to ' .. new_filename)
end

commands.lsp_rename_request = function(params, callback)
  local client = commands.find_client_with_supported_method('workspace/willRenameFiles')
  if client == nil then
    callback()
    return
  end

  local handler = function(err, result, _, _)
    if err then
      print('🐞🐞🐞 error occur while renaming')
      return
    end
    if result ~= nil and type(result) == 'table' then
      callback()
      vim.lsp.util.apply_workspace_edit(result, 'utf-8')
    end
  end

  local bufnr = vim.api.nvim_get_current_buf()
  client.request('workspace/willRenameFiles', params, handler, bufnr)
end

commands.lsp_rename_file = function(new_filename)
  local bufnr = vim.api.nvim_get_current_buf()
  local new_filepath = vim.fn.expand('%:p:h') .. '/' .. new_filename
  local new_uri = vim.uri_from_fname(new_filepath)
  local old_uri = vim.uri_from_bufnr(bufnr)
  local rename_file = {
    ['oldUri'] = old_uri,
    ['newUri'] = new_uri,
  }
  local params = {
    files = {rename_file}
  }
  commands.lsp_rename_request(params, function()
    commands.rename(new_filename)
  end)
end

commands.move = function(directory)
  local current_path = vim.fn.expand('%:p')
  local filename = vim.fn.expand('%:t')

  -- local clients = commands.detach_current_buf_lsp()

  vim.fn.mkdir(directory, 'p')
  vim.api.nvim_command('file ' .. directory .. '/' .. filename)
  vim.api.nvim_command('write!')
  vim.fn.delete(current_path)

  -- commands.attach_current_buf_lsp(clients)
  vim.api.nvim_command('redraw')

  print('🦫🦫🦫 Move file to ' .. directory)
end

commands.lsp_move_file = function(directory)
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.fn.expand('%:t')
  local new_filepath = vim.fn.getcwd() .. '/' .. directory .. '/' .. filename
  local new_uri = vim.uri_from_fname(new_filepath)
  local old_uri = vim.uri_from_bufnr(bufnr)
  local rename_file = {
    ['oldUri'] = old_uri,
    ['newUri'] = new_uri,
  }
  local params = {
    files = {rename_file}
  }
  commands.lsp_rename_request(params, function()
    commands.move(directory)
  end)
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
      commands.lsp_rename_file(opts.args)
      -- commands.rename(opts)
      refresh_nerdtree()
    end, { nargs = 1, complete = 'buffer' })

  vim.api.nvim_create_user_command('Move',
    function(opts)
      commands.lsp_move_file(opts.args)
      -- commands.move(opts)
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
