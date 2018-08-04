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
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-heroku'
NeoBundle 'mattn/emmet-vim'
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
NeoBundle 'garbas/vim-snipmate'
NeoBundle 'kiddos/snippets.vim'
NeoBundle 'kiddos/compile.vim'
NeoBundle 'kiddos/vim-ros'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'rhysd/vim-clang-format'
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
NeoBundle 'carlitux/deoplete-ternjs'
NeoBundle 'fishbullet/deoplete-ruby'
NeoBundle 'kiddos/deoplete-cpp'
NeoBundle 'mhartington/nvim-typescript'
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
NeoBundle 'beyondmarc/hlsl.vim'
NeoBundle 'kiddos/vim-protobuf'
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
NeoBundle 'HerringtonDarkholme/yats.vim'
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
NeoBundle 'digitaltoad/vim-pug'
NeoBundle 'briancollins/vim-jst'
NeoBundle 'evidens/vim-twig'
NeoBundle 'zeekay/vim-html2jade'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tpope/vim-markdown'
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

" file type settings {{{
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.i setlocal filetype=swig
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.swg setlocal filetype=swig
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.BUILD setlocal filetype=bzl
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.m setlocal filetype=matlab
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.mm setlocal filetype=objcpp
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.h setlocal filetype=cpp
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.ejs setlocal filetype=html
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.pro setlocal filetype=make
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.fcl setlocal filetype=fcl
" ros
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.msg setlocal filetype=rosmsg
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.launch setlocal filetype=xml
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.action setlocal filetype=rosaction
autocmd VimEnter,BufRead,BufNewFile,BufEnter *.srv setlocal filetype=rossrv
" }}}
" code display settings {{{
set modeline
set textwidth=80
" }}}
" code folding settings {{{
" default {{{
set foldmethod=marker
set foldmarker={,}
set foldlevel=1
" }}}
" c/c++/objc/objc++ {{{
autocmd FileType c,cpp,objc,objcpp,cuda,arduino normal zR
" }}}
" python {{{
autocmd FileType python setlocal foldmethod=indent
autocmd FileType python setlocal foldlevel=1
autocmd FileType python normal zR
" }}}
" ruby {{{
autocmd FileType ruby setlocal foldmethod=indent
autocmd FileType ruby setlocal foldlevel=1
autocmd FileType ruby normal zR
" }}}
" java {{{
autocmd FileType java normal zR
" }}}
" javascript {{{
autocmd FileType javascript normal zR
" }}}
" typescript {{{
autocmd FileType typescript normal zR
" }}}
" coffee script {{{
autocmd FileType coffee normal zR
" }}}
" sass {{{
autocmd FileType sass setlocal foldmethod=indent
" }}}
" php {{{
autocmd FileType php normal zR
" }}}
" html/xhtml/xml/haml/jst {{{
autocmd FileType html,xhtml,xml,haml,jst setlocal foldmethod=indent
autocmd FileType html,xhtml,xml,haml,jst setlocal foldlevel=0
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
" }}}
" indenting setting {{{
" default {{{
set autoindent
set expandtab
set smartindent
autocmd FileType c,cpp,arduino,cuda setlocal cindent
autocmd FileType c,cpp,arduino,cuda setlocal cinoptions=>1s,(-1s
set tabstop=4
set softtabstop=2
set shiftwidth=2
" }}}
" c/c++ indenting {{{
autocmd Filetype c,cpp,objc,objcpp,cuda,arduino setlocal cinoptions=(0,>1s,:2,g1,m1,+4
" }}}
" python indenting {{{
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
" fuzzy control language indenting {{{
autocmd FileType fcl setlocal noexpandtab
" }}}
" bazel build indenting {{{
autocmd FileType bzl setlocal nosmartindent
" }}}
" }}}
" editing settings {{{
set altkeymap
set backspace=indent,eol,start
set clipboard=unnamed,unnamedplus
set linebreak
set shiftround
set complete=.,w,b,u,U,t,k
set completeopt=menu,noinsert,noselect
set mouse=""
set autoread
set hidden
set cscopepathcomp=2
set nowritebackup
set formatoptions+=t
" }}}
" search settings {{{
set incsearch
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
" omni completeion settings {{{
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
" key maps settings {{{
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
" enter to complete popup {{{
inoremap <expr>	<CR> pumvisible() ? "\<C-N>\<C-Y>" : "\<CR>"
" }}}
" end line semicolon ; {{{
autocmd FileType c,cpp,cuda,arduino,objc,objcpp nnoremap ; $a;
autocmd FileType java,javascript,css,html,matlab,php,perl nnoremap ; $a;
" }}}
" }}}
" color scheme settings {{{
set cursorline
syntax enable
syntax on
colorscheme malokai
" }}}
" fixes {{{
" fix zsh escape lag
set timeoutlen=1000 ttimeoutlen=0
" }}}
" plugin settings {{{
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
\	'-I' . $HOME . '/.platformio/packages/framework-arduinoavr',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f0/Drivers/STM32F0xx_HAL_Driver/Inc',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f0/Drivers/CMSIS/Include',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f1/Drivers/STM32F1xx_HAL_Driver/Inc',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f1/Drivers/CMSIS/Include',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f2/Drivers/STM32F2xx_HAL_Driver/Inc',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f2/Drivers/CMSIS/Include',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f3/Drivers/STM32F3xx_HAL_Driver/Inc',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f3/Drivers/CMSIS/Include',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f4/Drivers/STM32F4xx_HAL_Driver/Inc',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f4/Drivers/CMSIS/Include',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f7/Drivers/STM32F7xx_HAL_Driver/Inc',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f7/Drivers/CMSIS/Include',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/l0/Drivers/STM32L0xx_HAL_Driver/Inc',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/l0/Drivers/CMSIS/Include',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/l1/Drivers/STM32L1xx_HAL_Driver/Inc',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/l1/Drivers/CMSIS/Include',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/l4/Drivers/STM32L4xx_HAL_Driver/Inc',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/l4/Drivers/CMSIS/Include',
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
\   '-Wno-sign-compare',
\   '-std=c++14',
\   '-fopenmp',
\   '-pthread',
\   '-fPIC',
\   '-DDEBUG', '-DQT_DEBUG', '-DKDEBUG_MESSAGE',
\	'-I../../devel/include',
\	'-I../devel/include',
\	'-I./devel/include',
\	'-I../../build',
\	'-I../build',
\	'-I./build',
\   '-I.',
\	'-Iinclude',
\	'-I../include',
\	'-Ibuild',
\	'-Ibuild/src',
\	'-I../build',
\	'-I../build/src',
\	'-Isrc',
\	'-I../src',
\	'-Ilib',
\	'-I../lib',
\	'-Isrc/main/c',
\	'-Isrc/main/cpp',
\	'-Isrc/main/jni',
\   '-I/usr/local/cuda/include',
\   '-I/usr/include/x86_64-linux-gnu/qt5',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtCLucene',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtConcurrent',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtCore',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtDBus',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtDesigner',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtDesignerComponents',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtGui',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtHelp',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtMultimedia',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtNetwork',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtOpenGL',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtOpenGLExtensions',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtPlatformHeaders',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtPlatformSupport',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtPrintSupport',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtQml',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtQmlDevTools',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtQuick',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtQuickParticles',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtQuickTest',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtQuickWidgets',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtScript',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtScriptTools',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtSql',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtSvg',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtTest',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtUiPlugin',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtUiTools',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtWebKit',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtWebKitWidgets',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtWidgets',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtXml',
\   '-I/usr/include/x86_64-linux-gnu/qt5/QtXmlPatterns',
\   '-I/usr/lib/jvm/java-8-oracle/include',
\   '-I/usr/lib/jvm/java-8-oracle/include/linux',
\   '-I/opt/ros/kinetic/include',
\   '-I/home/joseph/catkin_kinetic/devel/include',
\   '-I/home/joseph/catkin_indigo/install/include',
\   '-I/home/joseph/catkin_kinetic/install/include',
\   '-I/usr/local/lib/python2.7/dist-packages/tensorflow/include',
\   '-I/usr/include/mpi',
\   '-I/usr/include/pcl-1.7',
\   '-I/usr/include/libusb-1.0',
\	'-I' . $HOME . '/.platformio/packages/framework-arduinoavr/cores/arduino',
\	'-I' . $HOME . '/.platformio/packages/framework-arduinostm32/STM32F1/cores/maple',
\	'-I' . $HOME . '/.platformio/packages/framework-arduinostm32/STM32F4/cores/maple',
\	'-I' . $HOME . '/.platformio/packages/framework-mbed',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f1/Drivers/STM32F1xx_HAL_Driver/Inc',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f4/Drivers/STM32F4xx_HAL_Driver/Inc',
\	'-I' . $HOME . '/.platformio/packages/framework-arduino',
\	'-I' . $HOME . '/.platformio/packages/framework-arduinostm32',
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
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#auto_complete_start_length = 0
let g:deoplete#num_processes = 4
let g:deoplete#max_menu_width = 90
let g:deoplete#max_abbr_width = 36
let g:deoplete#enable_debug = 0
let g:deoplete#max_list = 6000
let g:deoplete#auto_complete_delay = 60
let g:deoplete#auto_refresh_delay = 1000
" deoplete-cpp {{{
let g:deoplete#sources#cpp#cflags = ['-std=c14']
let g:deoplete#sources#cpp#cppflags = ['-std=c++14']
let g:deoplete#sources#cpp#clang_version = '6.0'
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
let g:deoplete#sources#cpp#arduino_path = '/usr/share/arduino/'
let g:deoplete#sources#cpp#cpp_include_path = [
\	'../../devel/include',
\	'../devel/include',
\	'./devel/include',
\	'../../build',
\	'../build',
\	'./build',
\   '/usr/local/include',
\   '/usr/local/cuda/include',
\   '/usr/local/cuda',
\   '.',
\   'src',
\   'include',
\   'lib',
\	'build',
\	'build/src',
\   'third_party',
\   '../',
\   '../src',
\   '../include',
\   '../lib',
\   '../src',
\   '../include',
\	'../build',
\	'../build/src',
\   '../third_party',
\	'src/main/c',
\	'src/main/cpp',
\	'src/main/jni',
\   '/usr/lib/jvm/java-8-oracle/include',
\   '/usr/lib/jvm/java-8-oracle/include/linux',
\   '/usr/lib/gcc/x86_64-linux-gnu/5/include',
\   '/usr/include/x86_64-linux-gnu/qt5',
\   '/usr/include/x86_64-linux-gnu/qt5/QtCLucene',
\   '/usr/include/x86_64-linux-gnu/qt5/QtConcurrent',
\   '/usr/include/x86_64-linux-gnu/qt5/QtCore',
\   '/usr/include/x86_64-linux-gnu/qt5/QtDBus',
\   '/usr/include/x86_64-linux-gnu/qt5/QtDesigner',
\   '/usr/include/x86_64-linux-gnu/qt5/QtDesignerComponents',
\   '/usr/include/x86_64-linux-gnu/qt5/QtGui',
\   '/usr/include/x86_64-linux-gnu/qt5/QtHelp',
\   '/usr/include/x86_64-linux-gnu/qt5/QtMultimedia',
\   '/usr/include/x86_64-linux-gnu/qt5/QtNetwork',
\   '/usr/include/x86_64-linux-gnu/qt5/QtOpenGL',
\   '/usr/include/x86_64-linux-gnu/qt5/QtOpenGLExtensions',
\   '/usr/include/x86_64-linux-gnu/qt5/QtPlatformHeaders',
\   '/usr/include/x86_64-linux-gnu/qt5/QtPlatformSupport',
\   '/usr/include/x86_64-linux-gnu/qt5/QtPrintSupport',
\   '/usr/include/x86_64-linux-gnu/qt5/QtQml',
\   '/usr/include/x86_64-linux-gnu/qt5/QtQmlDevTools',
\   '/usr/include/x86_64-linux-gnu/qt5/QtQuick',
\   '/usr/include/x86_64-linux-gnu/qt5/QtQuickParticles',
\   '/usr/include/x86_64-linux-gnu/qt5/QtQuickTest',
\   '/usr/include/x86_64-linux-gnu/qt5/QtQuickWidgets',
\   '/usr/include/x86_64-linux-gnu/qt5/QtScript',
\   '/usr/include/x86_64-linux-gnu/qt5/QtScriptTools',
\   '/usr/include/x86_64-linux-gnu/qt5/QtSql',
\   '/usr/include/x86_64-linux-gnu/qt5/QtSvg',
\   '/usr/include/x86_64-linux-gnu/qt5/QtTest',
\   '/usr/include/x86_64-linux-gnu/qt5/QtUiPlugin',
\   '/usr/include/x86_64-linux-gnu/qt5/QtUiTools',
\   '/usr/include/x86_64-linux-gnu/qt5/QtWebKit',
\   '/usr/include/x86_64-linux-gnu/qt5/QtWebKitWidgets',
\   '/usr/include/x86_64-linux-gnu/qt5/QtWidgets',
\   '/usr/include/x86_64-linux-gnu/qt5/QtXml',
\   '/usr/include/x86_64-linux-gnu/qt5/QtXmlPatterns',
\   '/opt/ros/kinetic/include',
\   '/home/joseph/catkin_kinetic/devel/include',
\   '/home/joseph/catkin_kinetic/install/include',
\   '/usr/local/lib/python2.7/dist-packages/tensorflow/include',
\   '/usr/include/mpi',
\   '/usr/include/pcl-1.7',
\   '/usr/include/libusb-1.0',
\   '/usr/include/eigen3',
\	$HOME . '/.platformio/packages/framework-arduinoavr/cores/arduino',
\	$HOME . '/.platformio/packages/framework-arduinostm32/STM32F1/cores/maple',
\	$HOME . '/.platformio/packages/framework-arduinostm32/STM32F4/cores/maple',
\	$HOME . '/.platformio/packages/framework-mbed',
\	$HOME . '/.platformio/packages/framework-stm32cube/f0/Drivers/STM32F0xx_HAL_Driver/Inc',
\	$HOME . '/.platformio/packages/framework-stm32cube/f0/Drivers/CMSIS/Include',
\	$HOME . '/.platformio/packages/framework-stm32cube/f1/Drivers/STM32F1xx_HAL_Driver/Inc',
\	$HOME . '/.platformio/packages/framework-stm32cube/f1/Drivers/CMSIS/Include',
\	$HOME . '/.platformio/packages/framework-stm32cube/f2/Drivers/STM32F2xx_HAL_Driver/Inc',
\	$HOME . '/.platformio/packages/framework-stm32cube/f2/Drivers/CMSIS/Include',
\	$HOME . '/.platformio/packages/framework-stm32cube/f3/Drivers/STM32F3xx_HAL_Driver/Inc',
\	$HOME . '/.platformio/packages/framework-stm32cube/f3/Drivers/CMSIS/Include',
\	$HOME . '/.platformio/packages/framework-stm32cube/f4/Drivers/STM32F4xx_HAL_Driver/Inc',
\	$HOME . '/.platformio/packages/framework-stm32cube/f4/Drivers/CMSIS/Include',
\	$HOME . '/.platformio/packages/framework-stm32cube/f7/Drivers/STM32F7xx_HAL_Driver/Inc',
\	$HOME . '/.platformio/packages/framework-stm32cube/f7/Drivers/CMSIS/Include',
\	$HOME . '/.platformio/packages/framework-stm32cube/l0/Drivers/STM32L0xx_HAL_Driver/Inc',
\	$HOME . '/.platformio/packages/framework-stm32cube/l0/Drivers/CMSIS/Include',
\	$HOME . '/.platformio/packages/framework-stm32cube/l1/Drivers/STM32L1xx_HAL_Driver/Inc',
\	$HOME . '/.platformio/packages/framework-stm32cube/l1/Drivers/CMSIS/Include',
\	$HOME . '/.platformio/packages/framework-stm32cube/l4/Drivers/STM32L4xx_HAL_Driver/Inc',
\	$HOME . '/.platformio/packages/framework-stm32cube/l4/Drivers/CMSIS/Include',
\	$HOME . '/.platformio/packages/toolchain-atmelavr/avr/include',
\	$HOME . '/.platformio/packages/toolchain-atmelavr/include',
\	$HOME . '/.platformio/packages/toolchain-gccarmnoneeabi/arm-none-eabi/include',
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
" ternjs {{{
let g:deoplete#sources#ternjs#tern_bin = '/usr/bin/tern'
let g:deoplete#sources#ternjs#timeout = 3
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#include_keywords = 1
let g:deoplete#sources#ternjs#in_literal = 0
" }}}
" javacompelte2 {{{
let g:JavaComplete_UseFQN = 1
let g:JavaComplete_ClosingBrace = 1
let g:JavaComplete_ImportDefault = -1
" let g:JavaComplete_GradleExecutable = 'gradle'
" let g:JavaComplete_ImportSortType = 'jarName'
" let g:JavaComplete_LibsPath = '.:/home/joseph/.m2/repository:./libs:./lib'
" }}}
" jedi {{{
let g:deoplete#sources#jedi#server_timeout = 60
" }}}
" neosnippet settings {{{
" {{{ options
let g:neosnippet#disable_select_mode_mappings = 1
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#expand_word_boundary = 0
let g:neosnippet#snippets_directory = '~/.config/nvim/bundle/snippets.vim/snippets'
let g:neosnippet#disable_runtime_snippets = {
\   '_' : 1,
\ }
let g:neosnippet#expand_word_boundary = 1
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
" vim-ros setting {{{
let g:ros_catkin_workspace = '~/catkin_indigo'
" }}}
" clang-format settings {{{
let g:clang_format#code_style = 'google'
let g:clang_format#filetype_style_options = {
\   'cpp' : {
\     'Standard': 'C++11',
\     'ColumnLimit': 79,
\   },
\   'javascript' : {
\     'ColumnLimit': 79,
\   },
\ }
" }}}
" autopep8 settings {{{
let g:autopep8_indent_size=2
let g:autopep8_disable_show_diff=0
let g:autopep8_max_line_length=80
" let g:autopep8_ignore="W291,W391,E111,E113,E114,E121,E125,E127,E128,E221,E225,E226,E231,E302,E303,W391,E501,E701,F401"
" }}}
" js-beautify settings {{{
autocmd FileType javascript command! JSBeautify call JsBeautify()
autocmd FileType json command! JSONBeautify call JsonBeautify()
autocmd FileType jsx command! JSBeautify call JsxBeautify()
autocmd FileType html,htmldjango command! HTMLBeautify call HtmlBeautify()
autocmd FileType css command! CSSBeautify call CSSBeautify()
" }}}
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
