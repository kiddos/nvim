""
""	Author: Joseph Yu
""	Last Modified: 2021/09/13
""

call plug#begin('~/.config/nvim/plugged')
" color scheme {{{
Plug 'kiddos/malokai.vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'tomasr/molokai'
" }}}
" git {{{
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'gregsexton/gitv'
" }}}
" utility {{{
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'dense-analysis/ale'
Plug 'Raimondi/delimitMate'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
Plug 'arecarn/selection.vim'
Plug 'arecarn/crunch.vim'
Plug 'kiddos/snippets.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'junegunn/fzf.vim'
Plug 'kiddos/a.vim'
" }}}
call plug#end()

" lua scripts
lua require('plugins')
lua require('lsp')
lua require('plugin-settings')

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
" code display settings {{{
set modeline
set textwidth=120
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
" fzf.vim {{{
set rtp+=~/.fzf
nnoremap <C-P> :Files<CR>
" }}}
" ale settings {{{
let g:ale_linters = {
\  'python': ['flake8'],
\  'javascript': ['eslint'],
\  'javascriptreact': ['eslint']
\}
let g:ale_python_flake8_options = '--ignore=E111,E121,E123,E126,E226,E24,E704,W503,W504'
let g:ale_linters_ignore = {
\  'javascript': ['flow']
\}
" }}}
" delimitMate settings {{{
autocmd FileType html setlocal matchpairs+=<:>
autocmd FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
let delimitMate_expand_cr = 1
autocmd FileType javascript let b:delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1
let delimitMate_balance_matchpairs = 1
let delimitMate_insert_eol_marker = 2
let delimitMate_smart_matchpairs = ''
let delimitMate_smart_quotes = '\w\%#'
" imap <expr> <CR> pumvisible() ? "\<C-N>": "<Plug>delimitMateCR"
" }}}
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
" NERDcommenter settings {{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = {
\   'c': { 'left': '//' },
\   'arduino': { 'left': '//' },
\   'vim': { 'left': '"' },
\   'conf': { 'left': '#' },
\   'prototxt': { 'left': '#' }
\}
" }}}
" GitGutter settings {{{
let g:gitgutter_enabled = 0
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
" startify settings {{{
let g:startify_list_order = [
\   ['   My most recently used files in the current directory:'],
\   'dir',
\   ['   My most recently used files:'],
\   'files',
\   ['   Bookmarks:'],
\   'bookmarks',
\   ['   Sessions:'],
\   'sessions',
\ ]
let g:startify_files_number = 3
let g:startify_bookmarks = [
\   {'vimrc': '~/.vim/vimrc'},
\   {'nvimrc': '~/.config/nvim/init.vim'}]
let g:startify_custom_header =
\   map(split(system('fortune | cowsay -f $(ls /usr/share/cowsay/cows | shuf -n 1 | cut -d. -f1)'), '\n'), '"   ". v:val') + ['']
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1
let g:startify_enable_special = 0
" }}}
" apm server {{{
function StartAPMServer()
  silent exec ':!python3 ~/.config/nvim/apm_server.py --debug=False &'
endfunction
call StartAPMServer()
" }}}
" emmet settings {{{
let g:user_emmet_togglecomment_key = '<C-y>#'
" }}}
" a.vim settings {{{
nmap <leader><leader>a :A<CR>
" }}}
" NERDTree settings {{{
nmap <silent><F1> :NERDTreeToggle .<CR>
imap <F1> <Esc>:NERDTreeToggle .<CR>
" }}}
" GitGutter settings {{{
nmap <silent><F2> :GitGutterToggle<CR>
imap <F2> <Esc>:GitGutterToggle<CR>
" }}}
" barbar setting {{{
let bufferline = get(g:, 'bufferline', {})
let bufferline.icon_custom_colors = v:true
let bufferline.maximum_padding = 2
" nnoremap <silent>    <A-,> :BufferPrevious<CR>
" nnoremap <silent>    <A-.> :BufferNext<CR>
" Re-order to previous/next
" nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
" nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <leader>1 :BufferGoto 1<CR>
nnoremap <silent>    <leader>2 :BufferGoto 2<CR>
nnoremap <silent>    <leader>3 :BufferGoto 3<CR>
nnoremap <silent>    <leader>4 :BufferGoto 4<CR>
nnoremap <silent>    <leader>5 :BufferGoto 5<CR>
nnoremap <silent>    <leader>6 :BufferGoto 6<CR>
nnoremap <silent>    <leader>7 :BufferGoto 7<CR>
nnoremap <silent>    <leader>8 :BufferGoto 8<CR>
nnoremap <silent>    <leader>9 :BufferGoto 9<CR>
nnoremap <silent>    <leader>0 :BufferLast<CR>
" Close buffer
" nnoremap <silent>    <A-c> :BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout<CR>
" Close commands
"                          :BufferCloseAllButCurrent<CR>
"                          :BufferCloseBuffersLeft<CR>
"                          :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode
" nnoremap <silent> <C-s>    :BufferPick<CR>
" Sort automatically by...
" nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
" nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
" }}}
" }}}
