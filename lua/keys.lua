-- typo
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('QA', 'qa', {})

-- semicolon line endings
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

-- compile commands
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

vim.api.nvim_command([[
function! ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function! TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
]])
