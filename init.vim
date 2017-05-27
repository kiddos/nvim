""
""	Author: Joseph Yu
""	Last Modified: 2017/3/27
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
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-heroku'
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
NeoBundle 'kiddos/vim-ros'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'rhysd/vim-clang-format'
NeoBundle 'critiqjo/lldb.nvim'
" }}}
" deoplete {{{
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'Shougo/neco-vim'
NeoBundle 'Shougo/neoinclude.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'wellle/tmux-complete.vim'
NeoBundle 'zchee/deoplete-go'
NeoBundle 'zchee/deoplete-jedi'
NeoBundle 'zchee/deoplete-zsh'
NeoBundle 'c9s/perlomni.vim'
NeoBundle 'landaire/deoplete-swift'
NeoBundle 'carlitux/deoplete-ternjs'
NeoBundle 'fishbullet/deoplete-ruby'
NeoBundle 'kiddos/deoplete-cpp'
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
NeoBundle 'vim-scripts/Arduino-syntax-file'
NeoBundle 'chiphogg/vim-prototxt'
NeoBundle 'vim-scripts/SWIG-syntax'
NeoBundle 'vim-scripts/google.vim'
" " }}}
" python {{{
NeoBundle 'tell-k/vim-autopep8'
" }}}
" javascript   {{{
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'nono/jquery.vim'
NeoBundle 'moll/vim-node'
NeoBundle 'elzr/vim-json'
NeoBundle 'burnettk/vim-angular'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'maksimr/vim-jsbeautify'
" }}}
" lua {{{
NeoBundle 'xolox/vim-lua-ftplugin'
NeoBundle 'xolox/vim-misc'
" }}}
" perl {{{
NeoBundle 'vim-perl/vim-perl'
" }}}
" Java {{{
NeoBundle 'artur-shaik/vim-javacomplete2'
NeoBundle 'tfnico/vim-gradle'
" }}}
" vhdl {{{
NeoBundle 'kiddos/vim-vhdl'
NeoBundle 'vhda/verilog_systemverilog.vim'
" }}}
" ruby {{{
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
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
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" code display setting {{{
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
autocmd FileType conf,zsh setlocal foldmethod=marker
autocmd FileType conf,zsh setlocal foldmarker={,}
autocmd FileType conf,zsh setlocal foldlevel=3
autocmd FileType conf normal zM

autocmd FileType c,cpp,objc,objcpp,cuda setlocal foldmethod=marker
autocmd FileType java,javascript,css,php setlocal foldmethod=marker
autocmd FileType c,cpp,objc,objcpp,cuda setlocal foldmarker={,}
autocmd FileType java,javascript,css,php setlocal foldmarker={,}
autocmd FileType c,cpp,objc,objcpp,cuda setlocal foldlevel=1
autocmd FileType java,javascript,css,php setlocal foldlevel=1
autocmd FileType c,cpp,objc,objcpp,cuda,java,javascript,css,php normal zR

autocmd FileType html,xhtml,xml,haml,jst setlocal foldmethod=indent
autocmd FileType python,ruby setlocal foldmethod=indent
autocmd FileType python,ruby setlocal foldlevel=1
autocmd FileType html,xhtml,xml,haml,hst setlocal foldlevel=20
autocmd FileType html,xhtml,xml,haml,jst,ruby normal zR
autocmd FileType vim normal zM
" }}}
" editing settings {{{
" solve zsh escap delay
set timeoutlen=1000 ttimeoutlen=0
set altkeymap
set autoindent
set backspace=indent,eol,start
set clipboard=unnamed,unnamedplus
set encoding=utf-8
set ignorecase
set incsearch
set linebreak
set shiftround
set complete=.,w,b,u,U,t,k
set completeopt=menu,noinsert,noselect
set number
set mouse=""
" indent option
set expandtab
set cindent
set cinoptions=>1s,(-1s
set tabstop=4
set softtabstop=2
set shiftwidth=2
set smartindent
autocmd FileType bzl setlocal nosmartindent
" c/c++ indenting {{{
autocmd Filetype c,cpp,objc,objcpp,cuda,arduino setlocal cinoptions=(0,>1s,:2,g1,m1,+4
" }}}
" python indenting {{{
autocmd FileType python setlocal expandtab
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal softtabstop=2
autocmd FileType python setlocal shiftwidth=2
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
" }}}
" buffer settings {{{
set autoread
set confirm
set cscopepathcomp=2
set hidden
set icon
set iconstring=nvim
set nowritebackup
set formatoptions+=t
autocmd VimEnter,BufRead,BufNewFile *.i setlocal filetype=swig
autocmd VimEnter,BufRead,BufNewFile *.swg setlocal filetype=swig
autocmd VimEnter,BufRead,BufNewFile *.BUILD setlocal filetype=bzl
autocmd VimEnter,BufRead,BufNewFile *.m setlocal filetype=matlab
autocmd VimEnter,BufRead,BufNewFile *.mm setlocal filetype=objcpp
autocmd VimEnter,BufRead,BufNewFile *.h setlocal filetype=cpp
autocmd VimEnter,BufRead,BufNewFile *.ejs setlocal filetype=html
autocmd VimEnter,BufRead,BufNewFile *.pro setlocal filetype=make
autocmd VimEnter,BufRead,BufNewFile *.fcl setlocal filetype=fcl
" ros
autocmd VimEnter,BufRead,BufNewFile *.msg setlocal filetype=rosmsg
autocmd VimEnter,BufRead,BufNewFile *.launch setlocal filetype=roslaunch
autocmd VimEnter,BufRead,BufNewFile *.action setlocal filetype=rosaction
autocmd VimEnter,BufRead,BufNewFile *.srv setlocal filetype=rossrv
" }}}
" window settings {{{
set cmdheight=1
set cmdwinheight=6
set relativenumber
set fillchars=stl:\ ,stlnc:-,vert:\|,fold:-,diff:-
set langmenu=en_US.UTF-8
set laststatus=2
set pumheight=12
set report=6
set ruler
set showcmd
set noshowmode
set showtabline=2
set scroll=2
set splitright
set tabpagemax=20
set title
set warn
set wildmode=longest,full
set wildmenu
" }}}
" color scheme settings {{{
set cursorline
syntax enable
syntax on
colorscheme malokai
" }}}
" omni completeion {{{
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType cpp setlocal omnifunc=ccomplete#Complete
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType python setlocal omnifunc=python2complete#Complete
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType html,xhtml setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType javascript setlocal omnifunc=tern#Complete
" }}}
" custom key maps {{{
" leader {{{
let mapleader=","
let localleader="\\"
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
" enter to complete popup
inoremap <expr>	<CR> pumvisible() ? "\<C-N>\<C-Y>" : "\<CR>"
" end line semicolon ; {{{
autocmd	FileType  c	          nnoremap ; $a;
autocmd FileType  cpp         nnoremap ; $a;
autocmd FileType  cuda        nnoremap ; $a;
autocmd FileType  arduino     nnoremap ; $a;
autocmd	FileType  objc        nnoremap ; $a;
autocmd	FileType  objcpp      nnoremap ; $a;
autocmd	FileType  java        nnoremap ; $a;
autocmd	FileType  matlab      nnoremap ; $a;
autocmd	FileType  php         nnoremap ; $a;
autocmd	FileType  html        nnoremap ; $a;
autocmd	FileType  css         nnoremap ; $a;
autocmd	FileType  javascript  nnoremap ; $a;
autocmd	FileType  perl        nnoremap ; $a;
" }}}
" }}}
" airline settings {{{
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline_detect_crypt = 1
let g:airline_detect_iminsert = 1
let g:airline_inactive_collapse = 1
let g:airline_theme = 'tomorrow'
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
" }}}
" neomake settings {{{
autocmd! BufWritePost * Neomake
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
" c gcc maker {{{
let g:neomake_c_enabled_makers = ['gcc']
let g:neomake_c_gcc_args = [
\   '-fsyntax-only',
\   '-Wall',
\   '-Wextra',
\   '-Wno-pragmas',
\   '-Wno-unknown-pragmas',
\   '-Wno-pragma-once-outside-header',
\   '-DDEBUG', '-DQT_DEBUG', '-DKDEBUG_MESSAGE',
\   '-std=c11',
\   '-fopenmp',
\   '-pthread',
\   '-fPIC',
\	'-Iinclude',
\	'-I../include',
\	'-Isrc',
\	'-I../src',
\	'-Ilib',
\	'-I../lib',
\   '-I/usr/local/cuda/include',
\   '-I/usr/lib/gcc/x86_64-linux-gnu/4.8/include',
\   '-I/usr/src/linux-headers-4.2.8',
\   '-I/usr/src/linux-headers-4.2.8/include/',
\   ]
" }}}
" cpp gcc maker {{{
let g:neomake_cpp_enabled_makers = ['gcc']
let g:neomake_cpp_gcc_args = [
\   '-fsyntax-only',
\   '-Wall',
\   '-Wextra',
\   '-Wno-pragmas',
\   '-Wno-unknown-pragmas',
\   '-std=c++14',
\   '-fopenmp',
\   '-pthread',
\   '-fPIC',
\   '-DDEBUG', '-DQT_DEBUG', '-DKDEBUG_MESSAGE',
\   '-I.',
\	'-Iinclude',
\	'-I../include',
\	'-Isrc',
\	'-I../src',
\	'-Ilib',
\	'-I../lib',
\	'-Isrc/main/c',
\	'-Isrc/main/cpp',
\	'-Isrc/main/jni',
\   '-I/usr/local/cuda/include',
\   '-I/usr/include/x86_64-linux-gnu/qt5',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtConcurrent',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtCore',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtDBus',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtGui',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtNetwork',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtOpenGL',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtOpenGLExtensions',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtPlatformSupport',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtPrintSupport',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtSql',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtTest',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtWidgets',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtXml',
\   '-I/usr/lib/jvm/java-8-oracle/include',
\   '-I/usr/lib/jvm/java-8-oracle/include/linux',
\   '-I/opt/ros/indigo/include',
\   '-I/opt/ros/kinetic/include',
\   '-I/home/joseph/tools/arduino/hardware/arduino/avr/cores/arduino',
\   '-I/home/joseph/catkin_indigo/devel/include',
\   '-I/home/joseph/catkin_kinetic/devel/include',
\   '-I/home/joseph/catkin_indigo/install/include',
\   '-I/home/joseph/catkin_kinetic/install/include',
\   '-I/usr/local/lib/python2.7/dist-packages/tensorflow/include',
\   '-I/usr/include/mpi',
\   ]
" }}}
" cuda nvcc maker {{{
let g:neomake_cuda_nvcc_maker = {
\   'exe': 'nvcc',
\   'args': [
\     '-std=c++11',
\     '-Xcompiler',
\     '-fsyntax-only',
\     '-Xcompiler',
\     '-Wall',
\     '-Xcompiler',
\     '-Wextra',
\     '-o',
\     '-/dev/null'],
\   }
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
let g:neomake_cuda_enabled_makers = ['nvcc']
let g:neomake_echo_current_error = 1
" }}}
" python maker {{{
let g:neomake_python_enabled_makers = ['flake8', 'python']
let g:neomake_python_flake8_args = [
\   '--ignore=W291,W391,E111,E113,E114,E121,E125,E127,E128,E221,E225,E226,E231,E302,E303,W391,E501,E701,F401'
\]
" }}}
" {{{ javascript maker
let g:neomake_javascript_enabled_makers = ['jshint']
" }}}
" }}}
" NERDcommenter settings {{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = {
\   'c': { 'left': '/**', 'right': '*/' },
\   'arduino': { 'left': '/**', 'right': '*/' },
\   'vim': { 'left': '"' },
\   'conf': { 'left': '#' },
\   'prototxt': { 'left': '#' }
\}
" }}}
" indent line {{{
let g:indentLine_enabled = 0
" }}}
" GitGutter settings {{{
let g:gitgutter_enabled = 0
" }}}
" deoplete settings {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#max_menu_width = 96
let g:deoplete#max_abbr_width = 96
let g:deoplete#enable_debug = 0
let g:deoplete#max_list = 666
let g:deoplete#sources = {}
let g:deoplete#sources.c = ['file', 'cpp', 'cpp/include', 'neosnippet']
let g:deoplete#sources.cpp = ['file', 'cpp', 'cpp/include', 'neosnippet']
let g:deoplete#sources.objc = ['file', 'cpp', 'cpp/include', 'neosnippet']
let g:deoplete#sources.objcpp = ['file', 'cpp', 'cpp/include', 'neosnippet']
let g:deoplete#sources.cuda = ['file', 'cpp', 'cpp/include', 'neosnippet']
let g:deoplete#sources.arduino = ['file', 'cpp', 'cpp/include', 'neosnippet']
let g:deoplete#sources.java = ['file', 'file/include', 'java', 'neosnippet']
let g:deoplete#sources.python = ['file', 'file/include', 'jedi', 'neosnippet']
let g:deoplete#sources.cmake = ['file', 'cmake', 'neosnippet']
let g:deoplete#sources.vim = ['file', 'vim', 'neosnippet']
let g:deoplete#sources.javascript = ['file', 'ternjs', 'neosnippet']
" deoplete-cpp {{{
let g:deoplete#sources#cpp#cflags = ['-std=c14']
let g:deoplete#sources#cpp#cppflags = ['-std=c++14']
let g:deoplete#sources#cpp#c_include_path = [
\   '/usr/local/include',
\   '/usr/local/share/jdk1.8.0_66/include',
\   '/usr/local/share/jdk1.8.0_66/include/linux',
\   '/usr/local/cuda/include',
\   '/usr/local/cuda',
\   '/usr/src/linux-headers-4.2.8/include/',
\   '.',
\   'src',
\   'include',
\   '..',
\   '../src',
\   '../include',
\	'src/main/c',
\	'src/main/cpp',
\	'src/main/jni',
\ ]
let g:deoplete#sources#cpp#arduino_path = '/home/joseph/tools/arduino'
let g:deoplete#sources#cpp#cpp_include_path = [
\   '/usr/local/include',
\   '/usr/local/cuda/include',
\   '/usr/local/cuda',
\   '.',
\   'src',
\   'include',
\   'lib',
\   'third_party',
\   '../',
\   '../src',
\   '../include',
\   '../lib',
\   '../src',
\   '../include',
\   '../third_party',
\	'src/main/c',
\	'src/main/cpp',
\	'src/main/jni',
\   '/usr/lib/jvm/java-8-oracle/include',
\   '/usr/lib/jvm/java-8-oracle/include/linux',
\   '/usr/lib/gcc/x86_64-linux-gnu/5/include',
\   '/usr/include/x86_64-linux-gnu/qt5',
\   '/usr/include/x86_64-linux-gnu/qt5/QtConcurrent',
\   '/usr/include/x86_64-linux-gnu/qt5/QtCore',
\   '/usr/include/x86_64-linux-gnu/qt5/QtDBus',
\   '/usr/include/x86_64-linux-gnu/qt5/QtGui',
\   '/usr/include/x86_64-linux-gnu/qt5/QtNetwork',
\   '/usr/include/x86_64-linux-gnu/qt5/QtOpenGL',
\   '/usr/include/x86_64-linux-gnu/qt5/QtOpenGLExtensions',
\   '/usr/include/x86_64-linux-gnu/qt5/QtPlatformSupport',
\   '/usr/include/x86_64-linux-gnu/qt5/QtPrintSupport',
\   '/usr/include/x86_64-linux-gnu/qt5/QtSql',
\   '/usr/include/x86_64-linux-gnu/qt5/QtTest',
\   '/usr/include/x86_64-linux-gnu/qt5/QtWidgets',
\   '/usr/include/x86_64-linux-gnu/qt5/QtXml',
\   '/opt/ros/indigo/include',
\   '/opt/ros/kinetic/include',
\   '/home/joseph/catkin_indigo/devel/include',
\   '/home/joseph/catkin_kinetic/devel/include',
\   '/home/joseph/catkin_indigo/install/include',
\   '/home/joseph/catkin_kinetic/install/include',
\   '/usr/local/lib/python2.7/dist-packages/tensorflow/include',
\   '/usr/include/mpi',
\ ]
" }}}
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
" }}}
" javacompelte2 {{{
let g:JavaComplete_UseFQN = 1
let g:JavaComplete_ClosingBrace = 1
let g:JavaComplete_ImportDefault = -1
" let g:JavaComplete_GradleExecutable = 'gradle'
" let g:JavaComplete_ImportSortType = 'jarName'
" let g:JavaComplete_LibsPath = '.:/home/joseph/.m2/repository:./libs:./lib'
" }}}
" neosnippet settings {{{
" {{{ options
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = '~/.config/nvim/bundle/snippets.vim/snippets'
let g:neosnippet#disable_runtime_snippets = {
\   '_' : 1,
\ }
let g:neosnippet#enable_completed_snippet = 1
" }}}
" {{{ key maps
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <C-k> <Plug>(neosnippet_expand_or_jump)
" imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" }}}
" }}}
" }}}
" vim-javascript settings {{{
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
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
" switch.vim settings {{{
let g:switch_mapping = "-"
let g:switch_reverse_mapping = '+'
autocmd FileType c,cpp,objc,objcpp,cuda let b:switch_custom_definitions = [
\ {
\     '\<[a-z][a-z0-9]*_\k\+\>': {
\       '_\(.\)': '\U\1'
\     },
\     '\<[a-z0-9]\+[A-Z]\k\+\>': {
\       '\(\u\)': '_\l\1'
\     },
\   }
\ ]
" }}}
" ROS {{{
let g:ros_catkin_workspace = '~/catkin_indigo'
" }}}
" clang-format {{{
let g:clang_format#code_style = 'google'
let g:clang_format#style_options = {
\   "Standard" : "C++11",
\}
" }}}
" autopep8 {{{
let g:autopep8_indent_size=2
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=80
let g:autopep8_ignore="W291,W391,E111,E113,E114,E121,E125,E127,E128,E221,E225,E226,E231,E302,E303,W391,E501,E701,F401"
" }}}
" js-beautify {{{
autocmd FileType javascript command! JSBeautify call JsBeautify()
autocmd FileType json command! JSONBeautify call JsonBeautify()
autocmd FileType jsx command! JSBeautify call JsxBeautify()
autocmd FileType html command! HTMLBeautify call HtmlBeautify()
autocmd FileType css command! CSSBeautify call CSSBeautify()
" }}}
" useful functions and keybindings {{{
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
" a.vim shortcut
nmap  <leader><leader>a :A<CR>
"" }}}
