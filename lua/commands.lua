local uv = vim.uv or vim.loop

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

commands.set_typo_commands = function()
  vim.api.nvim_create_user_command('WQ', 'wq', {})
  vim.api.nvim_create_user_command('Wq', 'wq', {})
  vim.api.nvim_create_user_command('W', 'w', {})
  vim.api.nvim_create_user_command('Q', 'q', {})
  vim.api.nvim_create_user_command('Qa', 'qa', {})
  vim.api.nvim_create_user_command('QA', 'qa', {})
end

commands.set_semicolon_commands = function()
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

commands.set_compile_commands = function()
  local register_command = function(filetype, key, command)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetype,
      callback = function()
        local current = vim.api.nvim_get_current_buf()

        vim.api.nvim_buf_create_user_command(current, 'Compile', command, {
          force = true,
          desc = 'compile code',
        })

        local modes = { 'n', 'i' }
        for _, mode in pairs(modes) do
          vim.api.nvim_buf_set_keymap(current, mode, key, '', {
            silent = true,
            noremap = true,
            desc = 'compile code',
            callback = function()
              vim.api.nvim_command(command)
            end
          })
        end
      end,
    })
  end

  register_command({ 'c', 'cpp' }, '<F33>', '!clang++ % -Wall -Wextra -std=c++20 -fsanitize=address -O1 -g -o %:r')
  register_command({ 'rust' }, '<F33>', '!rustc %')
  register_command({ 'cuda' }, '<F33>', '!nvcc % -o %:r &')
  register_command({ 'java' }, '<F33>', '!javac % &')
  register_command({ 'kotlin' }, '<F33>', '!kotlinc % -include-runtime -d %:r.jar')
end

commands.toggle_highlight_trailing_space = function()
  local opts = {
    title = 'Highlight Trailing space',
    timeout = 300,
  }
  if context.highlight_group ~= nil then
    vim.fn.matchdelete(context.highlight_group)
    vim.notify('Disable highlight trailing space 🌚', vim.log.levels.INFO, opts)
    context.highlight_group = nil
  else
    context.highlight_group = vim.fn.matchadd('TrailingSpace', [[\v(\s+$)|( +\ze\t)]])
    -- context.highlight_group = vim.fn.matchadd('TrailingSpace', [[\s\+$]])
    vim.notify('Highlight trailing space 🌝', vim.log.levels.INFO, opts)
  end
end

commands.trim_trailing_space = function()
  vim.cmd([[keeppatterns %s/\s\+$//e]])
end

commands.set_trim_space_commands = function()
  vim.api.nvim_set_hl(0, 'TrailingSpace', {
    bg = '#864F4F',
    fg = '#864F4F',
    ctermfg = 160,
    ctermbg = 160,
  })

  vim.api.nvim_create_user_command('HighlightTrailingSpace', commands.toggle_highlight_trailing_space, {})
  vim.api.nvim_set_var('mapleader', ',')
  vim.api.nvim_set_keymap('n', '<F4>', '', {
    silent = true,
    noremap = true,
    callback = commands.toggle_highlight_trailing_space,
    desc = 'Highlight trailing space',
  })
  vim.api.nvim_create_user_command('TrimSpace', commands.trim_trailing_space, {})
end

commands.alternate_file = function()
  local current_path = vim.fn.expand('%:p')
  local current_extension = string.lower(vim.fn.fnamemodify(current_path, ':e'))
  local alternate_extensions = ALTERNATE_EXTENSIONS[current_extension]

  local function file_exists(filename)
    local stat = uv.fs_stat(filename)
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

commands.set_alternate_commands = function()
  vim.api.nvim_create_user_command('A', commands.alternate_file, {})
  vim.api.nvim_set_keymap('n', '<Leader><Leader>a', '', {
    silent = true,
    noremap = true,
    callback = commands.alternate_file,
    desc = 'Alternate file',
  })
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

commands.table_get = function(t, id)
  if type(id) ~= 'table' then return commands.table_get(t, { id }) end
  local success, res = true, t
  for _, i in ipairs(id) do
    success, res = pcall(function() return res[i] end)
    if not success or res == nil then return end
  end
  return res
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

  -- create directory
  local input_dir = vim.fn.fnamemodify(new_filename, ':h')
  local current_dir = vim.fn.expand('%:h')
  local dirname = current_dir
  if input_dir ~= '' then
    dirname = dirname .. '/' .. input_dir
  end
  vim.fn.mkdir(dirname, 'p')

  local old_path = vim.fn.expand('%:p')

  -- move the file
  local filename = vim.fn.fnamemodify(new_filename, ':t')
  vim.api.nvim_command('file! ' .. dirname .. '/' .. filename)
  vim.api.nvim_command('write!')

  -- delete the old file
  vim.fn.delete(old_path)

  vim.api.nvim_command('redraw')

  vim.notify('🦉🦉🦉  Rename file to ' .. new_filename, vim.log.levels.INFO, {
    title = 'Rename',
    timeout = 500,
  })
end

commands.lsp_rename_request = function(params, callback)
  local client = commands.find_client_with_supported_method('workspace/willRenameFiles')
  if client == nil then
    callback()
    return
  end

  local handler = function(err, result, _, _)
    if err then
      vim.notify('🐞🐞🐞 error occur while renaming', vim.log.levels.ERROR, {
        title = 'Rename',
        timeout = 500,
      })
      callback()
      return
    end
    if result ~= nil and type(result) == 'table' then
      vim.lsp.util.apply_workspace_edit(result, 'utf-8')
      callback()
    end
  end

  local bufnr = vim.api.nvim_get_current_buf()
  client.request('workspace/willRenameFiles', params, handler, bufnr)
end

commands.lsp_rename_file = function(opts)
  local new_filename = opts.args
  local bufnr = vim.api.nvim_get_current_buf()
  local new_filepath = vim.fn.expand('%:p:h') .. '/' .. new_filename
  local new_uri = vim.uri_from_fname(new_filepath)
  local old_uri = vim.uri_from_bufnr(bufnr)
  local rename_file = {
    ['oldUri'] = old_uri,
    ['newUri'] = new_uri,
  }
  local params = {
    files = { rename_file }
  }
  commands.lsp_rename_request(params, function()
    commands.rename(new_filename)
  end)
end

commands.move = function(directory)
  local current_path = vim.fn.expand('%:p')
  local filename = vim.fn.expand('%:t')

  vim.fn.mkdir(directory, 'p')
  vim.api.nvim_command('file! ' .. directory .. '/' .. filename)
  vim.api.nvim_command('write!')
  vim.fn.delete(current_path)

  vim.api.nvim_command('redraw')

  vim.notify('Move file to ' .. directory, vim.log.levels.INFO, {
    title = 'Move File',
    timeout = 500,
  })
end

commands.lsp_move_file = function(opts)
  local directory = opts.args
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
    files = { rename_file }
  }
  commands.lsp_rename_request(params, function()
    commands.move(directory)
  end)
end

commands.remove = function(_)
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
    vim.notify('🦨🦨🦨 File (' .. current_path .. ') deleted.', vim.log.levels.INFO, {
      title = 'Remove File',
      timeout = 500,
    })
  end
end

commands.mkdir = function(opts)
  local dirname = opts.args
  vim.fn.mkdir(dirname, 'p')
  vim.api.nvim_command('redraw')
  vim.notify('Directory created: ' .. dirname, vim.log.levels.INFO, {
    title = 'Mkdir',
    timeout = 500,
  })
end

commands.chmod = function(opts)
  local current_path = vim.fn.expand('%:p')
  local args = opts.args

  local function file_exists(filename)
    local stat = uv.fs_stat(filename)
    return stat and stat.type or false
  end

  if file_exists(current_path) then
    vim.api.nvim_command('!chmod ' .. args .. ' ' .. current_path)
    vim.api.nvim_command('redraw')
  end
end

commands.set_unix_commands = function()
  vim.api.nvim_create_user_command('Rename', commands.lsp_rename_file, { nargs = 1, complete = 'file' })
  vim.api.nvim_create_user_command('Move', commands.lsp_move_file, { nargs = 1, complete = 'file' })
  vim.api.nvim_create_user_command('Remove', commands.remove, {})
  vim.api.nvim_create_user_command('Mkdir', commands.mkdir, { nargs = 1, complete = 'file' })

  local chmod_options = function()
    return { '+x', '777', '664' }
  end
  vim.api.nvim_create_user_command('Chmod', commands.chmod, { nargs = 1, complete = chmod_options })
end

commands.set_tools_commands = function()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'sql' },
    callback = function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_create_user_command(bufnr, 'SqlFormat',
        function()
          vim.api.nvim_command('%!sqlformat --reindent --keywords upper --identifiers lower -')
        end, {})
    end,
  })

  vim.api.nvim_create_user_command('CountLines', function()
    vim.api.nvim_command('!git ls-files | xargs wc -l')
  end, {})

  vim.api.nvim_create_user_command('GWrite', function()
    vim.api.nvim_command('silent !git add %')
  end, {})

  vim.api.nvim_create_user_command('XMLFormat', function()
    vim.api.nvim_command('%!xmllint --format %')
  end, {})
end

commands.set_terminal = function()
  vim.api.nvim_set_keymap('t', '<Esc><Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

  vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
      vim.cmd("startinsert")
    end,
  })

  local term_context = {
    buf = -1,
    win = -1,
  }

  local create_terminal = function(input_buf)
    local buf = 0
    if vim.api.nvim_buf_is_valid(input_buf) then
      buf = input_buf
    else
      buf = vim.api.nvim_create_buf(false, true)
    end

    local win_width = vim.api.nvim_win_get_width(0)
    local win_height = vim.api.nvim_win_get_height(0)
    local width = 50
    local height = 16
    local opts = {
      relative = 'editor',
      width = width,
      height = height,
      col = win_width - width - 2,
      row = win_height - height - 2,
      style = 'minimal',
      border = 'rounded',
    }
    local win = vim.api.nvim_open_win(buf, true, opts)

    vim.api.nvim_create_autocmd('WinClosed', {
      callback = function(args)
        local win_id = tonumber(args.match)
        if win_id == term_context.win then
          term_context.win = -1
        end
      end,
      once = true,
    })

    return { win, buf }
  end

  local toggle_term = function()
    if not vim.api.nvim_win_is_valid(term_context.win) then
      local term = create_terminal(term_context.buf)
      term_context.win = term[1]
      term_context.buf = term[2]
      local buftype = vim.api.nvim_get_option_value('buftype', { buf = term_context.buf })
      if buftype ~= 'terminal' then
        vim.cmd.terminal()
      end
      vim.cmd('startinsert')
    else
      vim.api.nvim_win_hide(term_context.win)
    end
  end

  vim.api.nvim_create_user_command('ToggleTerm', toggle_term, {})
  vim.api.nvim_set_keymap('n', '<F6>', ':ToggleTerm<CR>', {
    silent = true,
    noremap = true
  })
end


commands.setup = function()
  commands.set_typo_commands()
  commands.set_semicolon_commands()
  commands.set_compile_commands()
  commands.set_trim_space_commands()
  commands.set_alternate_commands()
  commands.set_unix_commands()
  commands.set_tools_commands()
  commands.set_terminal()
end

return commands
