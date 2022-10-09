local commands = {}
local context = {
  highlight_group = nil
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
  -- vim.api.nvim_create_user_command('TrimSpaces', )
end

return commands
