""
""	Author: Joseph Yu
""	Last Modified: 2021/09/13
""

call plug#begin('~/.config/nvim/plugged')
" utility {{{
Plug 'kiddos/snippets.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" }}}
call plug#end()

" lua scripts
lua require('plugins')
lua require('lsp')

" lsp settings {{{
" sign {{{
" sign define LspDiagnosticsSignError text=🛑 texthl=Text linehl= numhl=
" sign define LspDiagnosticsSignWarning text=❗️ texthl=Text linehl= numhl=
" }}}
" commands {{{
command GotoDeclaration lua vim.lsp.buf.declaration()
command GotoImplementation lua vim.lsp.buf.implementation()
command GotoTypeDefinition lua vim.lsp.buf.type_definition()
command GotoReferences lua vim.lsp.buf.references()
command GotoDocumentSymbol lua vim.lsp.buf.document_symbol()
command GotoWorkspaceSymbol lua vim.lsp.buf.workspace_symbol()
command LspClients lua print(vim.inspect(vim.lsp.buf_get_clients()))
" }}}
" }}}
" file type settings {{{
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.i setlocal filetype=swig
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.swg setlocal filetype=swig
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.BUILD setlocal filetype=bzl
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.m setlocal filetype=objc
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.mm setlocal filetype=objcpp
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.h setlocal filetype=cpp
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.ejs setlocal filetype=html
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.pro setlocal filetype=make
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.fcl setlocal filetype=fcl
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.wmm setlocal filetype=webmacro
" }}}
" rendering settings {{{
set lazyredraw
set redrawtime=10000
" }}}
" code folding settings {{{
" default {{{
set foldmethod=marker
set foldmarker={,}
set foldlevel=1
" }}}
" python {{{
autocmd FileType python setlocal foldmethod=indent
autocmd FileType python setlocal foldlevel=1
" }}}
" lua {{{
autocmd FileType lua setlocal foldmethod=indent
autocmd FileType lua setlocal foldlevel=1
" }}}
" ruby {{{
autocmd FileType ruby setlocal foldmethod=indent
autocmd FileType ruby setlocal foldlevel=1
" }}}
" sass {{{
autocmd FileType sass setlocal foldmethod=indent
" }}}
" html/xhtml/xml/haml/jst {{{
autocmd FileType php,html,xhtml,xml,haml,jst setlocal foldmethod=indent
autocmd FileType php,html,xhtml,xml,haml,jst setlocal foldlevel=0
" }}}
" vim {{{
autocmd FileType vim setlocal foldmarker={{{,}}}
autocmd FileType vim setlocal foldlevel=0
" }}}
" conf {{{
autocmd FileType conf setlocal foldmarker={,}
autocmd FileType conf setlocal foldlevel=0
" }}}
" snippets {{{
autocmd FileType snippets setlocal foldmarker={,}
autocmd FileType snippets setlocal foldlevel=0
" }}}
" unfold at start {{{
autocmd FileType c,cpp,objc,objcpp,cuda,arduino normal zR
autocmd FileType lua normal zR
autocmd FileType csharp normal zR
autocmd FileType python,javascript normal zR
autocmd FileType html normal zR
autocmd FileType xml normal zR
autocmd FileType typescript normal zR
autocmd FileType dart normal zR
" }}}
" }}}
" indenting setting {{{
" default {{{
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
" set smartindent
set copyindent
" }}}
" c/c++ indenting {{{
" autocmd Filetype c,cpp,objc,objcpp,cuda,arduino setlocal cinoptions=>s,^0,:2,W4,m1,g1,)10,(0
autocmd Filetype c,cpp,objc,objcpp,cuda,arduino setlocal cindent
autocmd Filetype c,cpp,objc,objcpp,cuda,arduino setlocal cinoptions=w1,>1s,:1s,g1,m1,+2s,N-s
" }}}
" dart {{{
autocmd Filetype dart setlocal cindent
autocmd Filetype dart setlocal cinoptions=(1s,>1s,:1s,g1,m1,+2s
" }}}
" rust indenting {{{
autocmd FileType rust setlocal tabstop=2
autocmd FileType rust setlocal softtabstop=2
autocmd FileType rust setlocal shiftwidth=2
" }}}
" c# {{{
autocmd FileType cs setlocal tabstop=4
autocmd FileType cs setlocal softtabstop=4
autocmd FileType cs setlocal shiftwidth=4
" }}}
" python indenting {{{
let g:python_recommended_style = 0
" }}}
" java indenting {{{
autocmd FileType java setlocal tabstop=4
autocmd FileType java setlocal softtabstop=4
autocmd FileType java setlocal shiftwidth=4
" }}}
" make indenting {{{
autocmd FileType make setlocal noexpandtab
autocmd FileType make setlocal tabstop=4
autocmd FileType make setlocal softtabstop=2
autocmd FileType make setlocal shiftwidth=2
" }}}
" snippet indenting {{{
autocmd FileType snippets setlocal noexpandtab
autocmd FileType snippets setlocal tabstop=4
autocmd FileType snippets setlocal softtabstop=4
autocmd FileType snippets setlocal shiftwidth=4
" }}}
" fuzzy control language indenting {{{
autocmd FileType fcl setlocal noexpandtab
" }}}
" bazel build indenting {{{
autocmd FileType bzl setlocal nosmartindent
" }}}
" }}}
" editing settings {{{
set noautochdir
set cursorline
" set textwidth=120
set nowrap
set backspace=indent,eol,start
set clipboard=unnamed,unnamedplus
" set linebreak
set shiftround
set complete=.,w,b,u,U,t,k
set completeopt=menuone,noselect
set shortmess+=c
set mouse=nv
set autoread
set hidden
set cscopepathcomp=2
set nowritebackup
set formatoptions+=t
set wildignore=*.o,*.obj,*.out
" }}}
" search settings {{{
set incsearch
" set smartcase
set ignorecase
" }}}
" encoding settings {{{
set encoding=utf-8
set langmenu=en_US.UTF-8
" }}}
" window settings {{{
set confirm
set icon
set iconstring=nvim
set number
set cmdheight=1
set cmdwinheight=6
set relativenumber
set fillchars=stl:\ ,stlnc:-,vert:\|,fold:-,diff:-
set laststatus=2
set pumheight=20
set report=6
set ruler
set showcmd
set showmode
set scroll=2
set splitright
set tabpagemax=10
set title
set titlestring=%p
set warn
set wildmode=longest,full
set wildmenu
" }}}
" omni completion settings {{{
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType html,xhtml setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }}}
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
" buffer switching {{{
nmap <leader><leader>1 :b1<CR>
nmap <leader><leader>2 :b2<CR>
nmap <leader><leader>3 :b3<CR>
nmap <leader><leader>4 :b4<CR>
nmap <leader><leader>5 :b5<CR>
nmap <leader><leader>6 :b6<CR>
nmap <leader><leader>7 :b7<CR>
nmap <leader><leader>8 :b8<CR>
nmap <leader><leader>9 :b9<CR>
nmap <leader><leader>0 :b10<CR>
nmap gd :bd<CR>
nmap LL :bn<CR>
nmap HH :bp<CR>
nmap JJ :bn<CR>
nmap KK :bp<CR>
" }}}
" end line semicolon ; {{{
autocmd FileType c,cpp,cuda,arduino,objc,objcpp nnoremap ; $a;
autocmd FileType csharp nnoremap ; $a;
autocmd FileType java,matlab,php,perl nnoremap ; $a;
autocmd FileType javascript,css,html,typescript  nnoremap ; $a;
autocmd FileType javascriptreact,typescriptreact nnoremap ; $a;
" }}}
" compile {{{
autocmd FileType c,cpp command! Compile execute ':!clang++ % -o %:r'
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
" color scheme settings {{{
" let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
" set termguicolors
set background="dark"
syntax enable
syntax on
let g:material_theme_style = 'darker'
colorscheme malokai
" colorscheme material
" colorscheme molokai
" }}}
" plugin settings {{{
" airline settings {{{
let g:airline_disable_statusline = 1
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline_detect_crypt = 1
let g:airline_detect_iminsert = 1
let g:airline_inactive_collapse = 1
let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1


if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '⌨️ '
let g:airline_right_sep = '💻'
let g:airline_right_alt_sep = '💠'
let g:airline_left_alt_sep = '🛸'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '🔭'
let g:airline_symbols.maxlinenr = '🔬'
" let g:airline_symbols.branch = '🛠 '
let g:airline_symbols.branch = '🔀'
let g:airline_symbols.paste = '📑'
let g:airline_symbols.readonly = '⛔️'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.whitespace = '🕳 '
let g:airline_symbols.notexists = '🛑'
" airline-ale {{{
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = '🚫'
let airline#extensions#ale#warning_symbol = '⚠️ '
" }}}
" airline-branch {{{
let g:airline#extensions#branch#enabled = 1
" }}}
" airline-tabline {{{
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#show_splits = 0
" let g:airline#extensions#tabline#show_tab_count = 0
" let g:airline#extensions#tabline#show_buffers = 0
" let g:airline#extensions#tabline#show_tab_nr = 0
" let g:airline#extensions#tabline#overflow_marker = '…'
" let g:airline#extensions#tabline#current_first = 0
" let g:airline#extensions#tabline#tabs_label = ''
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#fnamecollapse = 0
" let g:airline#extensions#tabline#show_close_button = 0
" let g:airline#extensions#tabline#exclude_preview = 0
" let g:airline#extensions#tabline#buffer_nr_show = 0
" let g:airline#extensions#tabline#show_tab_type = 0
" nmap <leader>1 <Plug>AirlineSelectTab1
" nmap <leader>2 <Plug>AirlineSelectTab2
" nmap <leader>3 <Plug>AirlineSelectTab3
" nmap <leader>4 <Plug>AirlineSelectTab4
" nmap <leader>5 <Plug>AirlineSelectTab5
" nmap <leader>6 <Plug>AirlineSelectTab6
" nmap <leader>7 <Plug>AirlineSelectTab7
" nmap <leader>8 <Plug>AirlineSelectTab8
" nmap <leader>9 <Plug>AirlineSelectTab9
" nmap <leader>- <Plug>AirlineSelectPrevTab
" nmap <leader>+ <Plug>AirlineSelectNextTab
" }}}
" airline-nvimlsp {{{
let g:airline#extensions#nvimlsp#enabled = 1
let airline#extensions#nvimlsp#error_symbol = '🚫'
let airline#extensions#nvimlsp#warning_symbol = '⚠️ '
" }}}
" }}}
" neosnippet settings {{{
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_completed_snippet = 1
" let g:neosnippet#snippets_directory = '~/.config/nvim/bundle/snippets.vim/snippets'

imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" }}}
" apm server {{{
function StartAPMServer()
  silent exec ':!python3 ~/.config/nvim/apm_server.py --debug=False &'
endfunction
call StartAPMServer()
" }}}
" }}}
