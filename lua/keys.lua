-- typo
vim.api.nvim_command('command! WQ  wq')
vim.api.nvim_command('command! Wq  wq')
vim.api.nvim_command('command! W   w')
vim.api.nvim_command('command! Q   q')
vim.api.nvim_command('command! Qa  qa')
vim.api.nvim_command('command! QA  qa')

-- semicolon line endings
vim.api.nvim_command('augroup semicolon_ending')
vim.api.nvim_command('autocmd FileType c,cpp,cuda,arduino,objc,objcpp nnoremap ; $a;')
vim.api.nvim_command('autocmd FileType csharp nnoremap ; $a;')
vim.api.nvim_command('autocmd FileType java,matlab,php,perl nnoremap ; $a;')
vim.api.nvim_command('autocmd FileType javascript,css,html,typescript  nnoremap ; $a;')
vim.api.nvim_command('autocmd FileType javascriptreact,typescriptreact nnoremap ; $a;')
vim.api.nvim_command('autocmd FileType dart nnoremap ; $a;')
vim.api.nvim_command('augroup END')

-- compile commands
vim.api.nvim_command('augroup compile_command')
vim.api.nvim_command('autocmd FileType c,cpp command! Compile execute ":!clang++ % -Wall -std=c++17 -fsanitize=address -O1 -g -o %:r"')
vim.api.nvim_command('autocmd FileType cuda command! Compile execute ":!nvcc % -o %:r"')
vim.api.nvim_command('autocmd FileType java command! Compile execute ":!javac %"')
vim.api.nvim_command('augroup END')

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
