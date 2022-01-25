""
""	Author: Joseph Yu
""	Last Modified: 2021/10/24
""

lua require('plugins')
lua require('treesitter')
lua require('diagnostic')
lua require('lsp')

lua require('plugin-settings')

lua require('settings')
lua require('apm_server')

" key maps settings {{{
" leader {{{
let mapleader=","
let localleader="\\"
" }}}
" typo {{{
command! WQ  wq
command! Wq  wq
command! W   w
command! Q   q
command! Qa  qa
command! QA  qa
" }}}
" end line semicolon ; {{{
augroup semicolon_ending
autocmd FileType c,cpp,cuda,arduino,objc,objcpp nnoremap ; $a;
autocmd FileType csharp nnoremap ; $a;
autocmd FileType java,matlab,php,perl nnoremap ; $a;
autocmd FileType javascript,css,html,typescript  nnoremap ; $a;
autocmd FileType javascriptreact,typescriptreact nnoremap ; $a;
autocmd FileType dart nnoremap ; $a;
augroup END
" }}}
" compile {{{
autocmd FileType c,cpp command! Compile execute ':!clang++ % -Wall -std=c++17 -fsanitize=address -O1 -g -o %:r'
autocmd FileType cuda command! Compile execute ':!nvcc % -o %:r'
autocmd FileType java command! Compile execute ':!javac %'
" }}}
" remove trialing spaces {{{
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
" }}}
" }}}
