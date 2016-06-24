""
""	Author: Joseph Yu
""	Last Modified: 2016/6/7
""
if 0 | endif

set runtimepath^=~/.config/nvim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.config/nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
" color scheme {{{
NeoBundle 'kiddos/malokai.vim'
NeoBundle 'flazz/vim-colorschemes'
" }}}
" git {{{
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
NeoBundle 'gregsexton/gitv'
" }}}
" tmux {{{
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'benmills/vimux'
" }}}
" utility {{{
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'Shougo/dein.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', {'build': {'unix': 'make'}}
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-surround'
NeoBundle 'benekastah/neomake'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'ryanoasis/vim-devicons'
NeoBundle 'mhinz/vim-startify'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'mbbill/undotree'
NeoBundle 'kannokanno/previm'
NeoBundle 'arecarn/crunch.vim'
NeoBundle 'arecarn/selection.vim'
NeoBundle 'chrisbra/csv.vim'
NeoBundle 'garbas/vim-snipmate'
NeoBundle 'kiddos/snippets.vim'
NeoBundle 'kiddos/compile.vim'
NeoBundle 'godlygeek/tabular'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'thinca/vim-quickrun'
" NeoBundle 'vim-scripts/AutoComplPop'
" }}}
" deoplete {{{
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'Shougo/neco-vim'
NeoBundle 'Shougo/neoinclude.vim'
" NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'zchee/deoplete-clang'
NeoBundle 'carlitux/deoplete-ternjs'
NeoBundle 'zchee/deoplete-jedi'
NeoBundle 'kiddos/deoplete-cpp'
"NeoBundle 'zchee/deoplete-go'
" }}}
" libs {{{
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'
" }}}
" C family {{{
NeoBundle 'octol/vim-cpp-enhanced-highlight'
NeoBundle 'kiddos/a.vim'
NeoBundle 'beyondmarc/opengl.vim'
NeoBundle 'tikhomirov/vim-glsl'
" " }}}
" Java {{{
NeoBundle 'artur-shaik/vim-javacomplete2'
NeoBundle 'tpope/vim-classpath'
" }}}
" vhdl {{{
NeoBundle 'kiddos/vim-vhdl'
NeoBundle 'vhda/verilog_systemverilog.vim'
" }}}
" ruby {{{
NeoBundle 'osyo-manga/vim-monster'
NeoBundle 'tpope/vim-rails'
" }}}
" php {{{
NeoBundle 'stanangeloff/php.vim'
NeoBundle 'shawncplus/phpcomplete.vim'
" }}}
" html {{{
NeoBundle 'othree/html5.vim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'briancollins/vim-jst'
NeoBundle 'evidens/vim-twig'
NeoBundle 'lambdatoast/elm.vim'
NeoBundle 'zeekay/vim-html2jade'
NeoBundle 'coachshea/jade-vim'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'mattn/emmet-vim'
" }}}
" css {{{
NeoBundle 'ap/vim-css-color'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'groenewege/vim-less'
NeoBundle '1995eaton/vim-better-css-completion'
" }}}
" javascript   {{{
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'nono/jquery.vim'
NeoBundle 'moll/vim-node'
NeoBundle 'elzr/vim-json'
NeoBundle 'burnettk/vim-angular'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'ternjs/tern_for_vim'
" }}}
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"" code display setting {{{
" line width before auto newline
set modeline
autocmd FileType c,cpp,objc,objcpp,cs,asm,vhdl set textwidth=80
autocmd FileType java,python,ruby,eruby,javascript set textwidth=80
autocmd FileType matlab,r,vim set textwidth=80
autocmd FileType html,elm,twig,jade,ejs,jst set textwidth=100
autocmd FileType css,less,sass,scss set textwidth=80
" code folding
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldmarker={{{,}}}
autocmd FileType vim setlocal foldlevel=1
autocmd FileType conf setlocal foldmethod=marker
autocmd FileType conf setlocal foldmarker={,}
autocmd FileType conf setlocal foldlevel=1

autocmd FileType c,cpp,objc,objcpp setlocal foldmethod=marker
autocmd FileType java,javascript,css,php setlocal foldmethod=marker
autocmd FileType c,cpp,objc,objcpp setlocal foldmarker={,}
autocmd FileType java,javascript,css,php setlocal foldmarker={,}
autocmd FileType c,cpp,objc,objcpp setlocal foldlevel=2
autocmd FileType java,javascript,css,php setlocal foldlevel=2
autocmd FileType c,cpp,objc,objcpp,java,javascript,css,php normal zR

autocmd FileType html,xhtml,xml,haml,jst setlocal foldmethod=indent
autocmd FileType python,ruby setlocal foldmethod=indent
autocmd FileType python,ruby setlocal foldlevel=2
autocmd FileType html,xhtml,xml,haml,hst setlocal foldlevel=20
autocmd FileType html,xhtml,xml,haml,jst,python,ruby normal zR
"" }}}
"" editing settings {{{
set altkeymap
set autoindent
set backspace=indent,eol,start
set clipboard=unnamed,unnamedplus
set cindent
set encoding=utf-8
set ignorecase
set incsearch
set linebreak
set shiftround
set complete=.,w,b,u,U,t,k
set completeopt=menu,noinsert,noselect
set number
set mouse=""
set expandtab
set tabstop=4
set softtabstop=2
set shiftwidth=2
set smartindent
" solve zsh escap delay
set timeoutlen=1000 ttimeoutlen=0
" python indenting {{{
autocmd FileType python setlocal expandtab
autocmd FileType python setlocal tabstop=8
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal shiftwidth=4
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
" fuzzy control language {{{
autocmd FileType fcl setlocal noexpandtab
autocmd FileType fcl setlocal tabstop=4
autocmd FileType fcl setlocal softtabstop=4
autocmd FileType fcl setlocal shiftwidth=4
" }}}
"" }}}
"" buffer settings {{{
set autoread
set backupdir=.,~/.vimtmp,/tmp
set confirm
set cscopepathcomp=2
set directory=.,~/.vimtmp,/tmp
set hidden
set icon
set iconstring=nvim
set nowritebackup
set formatoptions+=t
autocmd VimEnter,BufRead,BufNewFile *.m setlocal filetype=matlab
autocmd VimEnter,BufRead,BufNewFile *.h setlocal filetype=cpp
autocmd VimEnter,BufRead,BufNewFile *.ejs setlocal filetype=html
autocmd VimEnter,BufRead,BufNewFile *.pro setlocal filetype=make
autocmd VimEnter,BufRead,BufNewFile *.fcl setlocal filetype=fcl
"" }}}
"" window settings {{{
set cmdheight=1
set cmdwinheight=6
set relativenumber
set fillchars=stl:\ ,stlnc:-,vert:\|,fold:-,diff:-
set langmenu=en_US.UTF-8
set laststatus=2
set pumheight=6
set report=2
set ruler
set showcmd
set noshowmode
set showtabline=2
set scroll=2
set splitright
set tabpagemax=20
set title
set warn
""" }}}
"" color scheme settings {{{
"set cursorcolumn
set cursorline
set background=dark
syntax enable
syntax on
set t_Co=256
colorscheme malokai
"" }}}
"" omni completeion {{{
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType cpp setlocal omnifunc=ccomplete#Complete
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType python setlocal omnifunc=python3complete#Complete
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType html,xhtml setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType javascript setlocal omnifunc=tern#Complete
"" }}}
"" custom key maps {{{
" leader {{{
let mapleader=","
let localleader="\\"
" }}}
" copy, paste, save, undo {{{
inoremap <C-C> <Esc>yyi
inoremap <C-V> <Esc>pa
inoremap <C-S> <Esc>:w
inoremap <C-Z> <Esc>ua
" }}}
" fix clipboard problem {{{
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction
vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
onoremap <silent> y y:call ClipboardYank()<cr>
onoremap <silent> d d:call ClipboardYank()<cr>
" nnoremap <silent> p :call ClipboardPaste()<cr>p
" }}}
" typo {{{
command!  WQ  wq
command!  Wq  wq
command!  W w
command!  Q q
command!  Qa  qa
command!  QA  qa
" }}}
" large movement {{{
nmap J  <C-D>
nmap K  <C-U>
nmap H  <C-E>
nmap L  <C-Y>
" }}}
" tab switching {{{
nmap  <leader>1	1gt
nmap  <leader>2	2gt
nmap  <leader>3	3gt
nmap  <leader>4	4gt
nmap  <leader>5	5gt
nmap  <leader>6	6gt
nmap  <leader>7	7gt
nmap  <leader>8	8gt
nmap  <leader>9	9gt
" }}}
" split tab {{{
nmap <leader><leader>v :vsplit<CR>
nmap <leader><leader>s :tabedit<CR>
nmap <leader><leader>c :tabclose<CR>
" }}}
inoremap <expr>	<CR> pumvisible() ? "\<C-N>\<C-Y>" : "\<CR>"
function! Toggle_C_Family_Type()
  if &filetype == 'c'
    execute ":setlocal filetype=cpp"
  elseif &filetype == 'cpp'
    execute ":setlocal filetype=objc"
  elseif &filetype == 'objc'
    execute ":setlocal filetype=c"
  endif
endfunction
nmap <silent> <leader><leader>t :call Toggle_C_Family_Type()<CR>
" end line semicolon ; {{{
autocmd	FileType  c	          nnoremap ; $a;
autocmd FileType  cpp         nnoremap ; $a;
autocmd FileType  arduino     nnoremap ; $a;
autocmd	FileType  objc        nnoremap ; $a;
autocmd	FileType  java        nnoremap ; $a;
autocmd	FileType  matlab      nnoremap ; $a;
autocmd	FileType  php         nnoremap ; $a;
autocmd	FileType  html        nnoremap ; $a;
autocmd	FileType  css         nnoremap ; $a;
autocmd	FileType  javascript  nnoremap ; $a;
" }}}
"" }}}
"" airline settings {{{
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline_detect_crypt = 1
let g:airline_detect_iminsert = 1
let g:airline_inactive_collapse = 1
let g:airline_theme = 'murmur'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '⊳'
let g:airline_right_sep = '⊲ '
let g:airline_right_alt_sep = '⌘ '
let g:airline_left_alt_sep = ''
let g:airline_symbols.crypt = '☠'
let g:airline_symbols.linenr = '⇵ '
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.paste = '℘  '
let g:airline_symbols.readonly = ''
let g:airline_symbols.whitespace = '⇆ '
"" }}}
"" tmuxline settings {{{
" let g:tmuxline_preset = 'airline'
"" }}}
"" Neomake settings {{{
autocmd! BufWritePost * Neomake
autocmd FileType c setlocal makeprg="gcc"
autocmd FileType cpp setlocal makeprg="g++"
autocmd FileType java setlocal makeprg="javac"
autocmd FileType python setlocal makeprg="python"
autocmd FileType javascript setlocal makeprg="jshint"
autocmd FileType ruby setlocal makeprg="jruby"
autocmd FileType css setlocal makeprg="csslint"
autocmd FileType sh setlocal makeprg="shellcheck"
autocmd FileType markdown setlocal makeprg="mdl"

let g:neomake_error_sign = {
\   'text': '✗',
\   'texthl': 'NeomakeError',
\   }
let g:neomake_warning_sign = {
\   'text': '⚠',
\   'texthl': 'NeomakeWarning',
\   }
highlight NeomakeError    cterm=BOLD  ctermfg=253 ctermbg=124 guifg=white guibg=red
highlight NeomakeWarning  cterm=BOLD  ctermfg=253 ctermbg=124 guifg=white guibg=red
" c clang maker {{{
let g:neomake_c_enabled_makers = ['clang']
let g:neomake_c_clang_args = [
\   '-fsyntax-only',
\   '-Wall',
\   '-Wextra',
\   '-std=c11',
\   '-fopenmp',
\   '-pthread',
\   '-fPIC',
\   '-DDEBUG',
\	'-Iinclude',
\	'-I../include',
\	'-Isrc',
\	'-I../src',
\   '-I/usr/lib/gcc/x86_64-linux-gnu/4.8/include',
\   '-I/usr/src/linux-headers-4.2.8',
\   '-I/usr/src/linux-headers-4.2.8/include/',
\   ]
"}}}
" cpp clang maker {{{
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_args = [
\   '-fsyntax-only',
\   '-Wall',
\   '-Wextra',
\   '-std=c++11',
\   '-fopenmp',
\   '-pthread',
\   '-fPIC',
\   '-DDEBUG', '-DQT_DEBUG',
\	'-Iinclude',
\	'-I../include',
\	'-Isrc',
\	'-I../src',
\	'-I../../Cserial/include',
\	'-I../Cserial/include',
\	'-ICserial/include',
\   ]
"}}}
" nvidia cuda maker {{{
let g:neomake_cuda_nvcc_maker = {
\   'exe': 'nvcc',
\   'args': [
\     '--cuda',
\     '-std=c++11',
\     '-Xcompiler',
\     '-fsyntax-only',
\     '-Xcompiler',
\     '-Wall',
\     '-Xcompiler',
\     '-Wextra',
\     '-Xcompiler',
\     '-fopenmp',
\   ],
\   'errorformat':
\       '%*[^"]"%f"%*\D%l: %m,'.
\       '"%f"%*\D%l: %m,'.
\       '%-G%f:%l: (Each undeclared identifier is reported only once,'.
\       '%-G%f:%l: for each function it appears in.),'.
\       '%f:%l:%c:%m,'.
\       '%f(%l):%m,'.
\       '%f:%l:%m,'.
\       '"%f"\, line %l%*\D%c%*[^ ] %m,'.
\       '%D%*\a[%*\d]: Entering directory `%f'','.
\       '%X%*\a[%*\d]: Leaving directory `%f'','.
\       '%D%*\a: Entering directory `%f'','.
\       '%X%*\a: Leaving directory `%f'','.
\       '%DMaking %*\a in %f,'.
\       '%f|%l| %m',
\   }
let g:neomake_cuda_clean_maker = {
\   'exe': 'rm',
\   'args': [expand('%:p').'.cpp.ii'],
\   'append_file': 0,
\   'errorformat': '%f:%l:%c: %m'
\   }
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
let g:neomake_cuda_enabled_makers = ['nvcc']
let g:neomake_echo_current_error = 1
"}}}
" pyhon maker {{{
let g:neomake_python_enabled_makers = ['flake8', 'python']
let g:neomake_python_flake8_args = [
\   '--ignore=E501,E225,E302,E303,W391,E226,E231,E701,E128,E113,E125,E127,E221,E701,W391'
\]
"""}}}
" }}}
"" NERDcommenter settings {{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = {
\   'c': { 'left': '/**', 'right': '*/' },
\   'arduino': { 'left': '/**', 'right': '*/' },
\   'vim': { 'left': '"' },
\   'conf': { 'left': '#' }
\}
"}}}
"" Arduino setttings {{{
let g:vim_arduino_map_keys = 0
" arduino commands
command! ArduinoCompile       call ArduinoCompile()
command! ArduinoDeploy        call ArduinoDeploy()
command! ArduinoSerialMonitor call ArduinoSerialMonitor()
" }}}
"" indent line {{{
let g:indentLine_enabled = 0
"" }}}
"" GitGutter settings {{{
let g:gitgutter_enabled = 0
"" }}}
"" deoplete settings {{{
call deoplete#custom#set('buffer', 'min_pattern_length', 64)
call deoplete#custom#set('clang', 'max_menu_width', 66)
call deoplete#custom#set('clang', 'max_abbr_width', 66)
call deoplete#custom#set('javacomplete2', 'max_abbr_width', 30)
call deoplete#custom#set('javacomplete2', 'max_menu_width', 36)

call deoplete#custom#set('c', 'matchers', ['matcher_fuzzy'])
call deoplete#custom#set('cpp', 'matchers', ['matcher_fuzzy'])
call deoplete#custom#set('cpp', 'converters', [
\   'converter_remove_overlap', 'converter_truncate_abbr',
\   'converter_truncate_menu', 'converter_auto_paren',
\   'converter_auto_delimiter'
\])
call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#max_menu_width = 90
let g:deoplete#max_abbr_width = 90
let g:deoplete#enable_debug = 0
let g:deoplete#max_list = 36
let g:deoplete#sources = {}
let g:deoplete#sources.c = ['file', 'cpp']
let g:deoplete#sources.cpp = ['file', 'cpp']
let g:deoplete#sources.objc = ['file', 'cpp']
let g:deoplete#sources.objcpp = ['file', 'cpp']
let g:deoplete#sources.arduino = ['cpp']
let g:deoplete#sources.java = ['javacomplete2']
let g:deoplete#sources.python = ['file', 'jedi']
let g:deoplete#sources.cmake = ['cmake']
" deoplete-clang {{{
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.6/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.6/include'
let g:deoplete#sources#clang#std#c = 'c11'
let g:deoplete#sources#clang#std#cpp = 'c++11'
let g:deoplete#sources#clang#sort_algo = 'priority'
let g:deoplete#sources#clang#flags = [
\   '-I/usr/lib/gcc/x86_64-linux-gnu/4.8/include',
\   '-I/usr/local/share/arduino/hardware/arduino/cores/arduino',
\   '-I/usr/local/share/arduino/hardware/arduino/cores/robot',
\   '-I/usr/src/linux-headers-4.2.8/include/',
\   '-I/usr/local/cuda-7.5/include/',
\   '-I../include',
\   '-Iinclude',
\   '-I../src',
\   '-Isrc'
\   ]
function SetQtSourceFlags()
  let g:deoplete#sources#clang#flags += [
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/Enginio',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DCore',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DInput',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DQuick',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DQuickRenderer',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DRenderer',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtBluetooth',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtCLucene',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtConcurrent',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtCore',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtDBus',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtDeclarative',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtDesigner',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtDesignerComponents',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtGui',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtHelp',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtLocation',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtMultimedia',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtMultimediaQuick_p',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtMultimediaWidgets',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtNetwork',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtNfc',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtOpenGL',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtOpenGLExtensions',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtPlatformHeaders',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtPlatformSupport',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtPositioning',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtPrintSupport',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtQml',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtQmlDevTools',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtQuick',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtQuickParticles',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtQuickTest',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtQuickWidgets',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtScript',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtScriptTools',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtSensors',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtSerialPort',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtSql',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtSvg',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtTest',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtUiPlugin',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtUiTools',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebChannel',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebEngine',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebEngineWidgets',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebKit',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebKitWidgets',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebSockets',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWebView',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtWidgets',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtX11Extras',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtXml',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtXmlPatterns',
  \	'-I/opt/Qt5.5.0/5.5/gcc_64/include/QtZlib'
  \]
endfunction
" }}}
" }}}
"" startify settings {{{
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
\   {'vimrc': '  ~/.vim/vimrc'},
\   {'nvimrc': '  ~/.config/nvim/init.vim'}]
let g:startify_custom_header =
\   map(split(system('tips.py | cowsay -f $(ls /usr/share/cowsay/cows | shuf -n 1 | cut -d. -f1)'), '\n'), '"   ". v:val') + ['']
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1
let g:startify_enable_special = 0
"" }}}
"" Unite settings {{{
" fuzzy search
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader><leader>f :Unite -start-insert file_rec<CR>
" bookmark this buffer
nnoremap <leader><leader>b execute ":UniteBookmarkAdd ".expand('%').'<CR>'
"" }}}
"" useful functions and keybindings {{{
function! Test_Webpage()
  if &ft == "php"
    echom "php file type"
    let dst = expand('%:t') . ".html"
    let temp = tempname()
    execute ":silent ! php % > " . dst
    execute ":silent ! google-chrome " . dst " > " . temp . " 2>&1 "
    execute ":pclose!"
    execute ":redraw!"
    set splitbelow
    execute ":6split"
    execute ":e! " . temp
    set nosplitbelow
    let delStatus = delete(dst)
    if delStatus != 0
      echo "Fail to Delete temp file"
    endif
  elseif &ft == "html"
    let this_file = expand('%:p')
    echom "html file type"
    execute ":silent ! google-chrome \"" . this_file . "\""
    execute ":pclose!"
    execute ":redraw!"
  endif
endfunction

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

function! Quick_Compile()
  if &ft == "c" || &ft == "cpp"
    call Compile_CXX_Basic()
  elseif &ft == "less" || &ft == "scss" || &ft == "sass"
    call Compile_to_CSS()
  elseif &ft == "php" || &ft == "html"
    call Test_Webpage()
  elseif &ft == "jade"
    call Compile_to_HTML()
  elseif &ft == "arduino"
    call ArduinoCompile()
  endif
endfunction

function! Split_Vimux()
  let g:VimuxOrientation="h"
  let g:VimuxHeight="50"
  call VimuxOpenRunner()
  let g:VimuxOrientation="v"
  let g:VimuxHeight="20"
endfunction

" commands
command! -bar -nargs=?          ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
"autocmd BufWritePost *.less,*.sass,*.scss call Compile_to_CSS()
command! CompiletoCSS     call Compile_to_CSS()
command! ToggleDotMFiles  call Toggle_filetype_dot_m()
command! OpenglGLFW3      call Compile_CPP_OpenGL_GLFW3()
command! ALLEGRO5         call Compile_CPP_ALLEGRO5()

" function keys
nmap  <silent><F1>  :NERDTreeToggle .<CR>
imap  <F1>  <Esc>:NERDTreeToggle .<CR>
nmap  <silent><F2>  :GitGutterToggle<CR>
imap  <F2>  <Esc>:GitGutterToggle<CR>
nmap  <silent><F3>  :IndentLinesToggle<CR>
imap  <F3>  <Esc>:IndentLinesToggle<CR>
nmap  <silent><F5>  :call Quick_Compile()<CR>
imap  <F5>  <Esc>:call Quick_Compile()<CR>
nmap  <silent><F6>  :setlocal spell!<CR>
imap  <F6>  <Esc>:setlocal spell!<CR>
" tabularize shortcut
nmap  <leader><space> :Tabularize / <CR>
nmap  <leader>"       :Tabularize /"[^"]*"<CR>
nmap  <leader>(       :Tabularize /(.*)<CR>
nmap  <leader>=       :Tabularize /= <CR>
" a.vim shortcut
nmap  <leader><leader>a :A<CR>
nmap  <leader>b :call Split_Vimux()<CR>
"" }}}
