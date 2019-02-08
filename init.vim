""
""	Author: Joseph Yu
""	Last Modified: 2018/10/29
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
NeoBundle 'elzr/vim-json'
NeoBundle 'burnettk/vim-angular'
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'leafgarland/typescript-vim'
" }}}
" go {{{
NeoBundle 'fatih/vim-go'
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
NeoBundle 'padawan-php/deoplete-padawan'
" }}}
" css {{{
NeoBundle 'ap/vim-css-color'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'groenewege/vim-less'
NeoBundle '1995eaton/vim-better-css-completion'
" }}}
" solidity {{{
NeoBundle 'tomlion/vim-solidity'
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
" }}}
" indenting setting {{{
" default {{{
set tabstop=4
set softtabstop=2
set shiftwidth=2
set autoindent
set expandtab
set smartindent
autocmd FileType c,cpp,arduino,cuda setlocal cindent
autocmd FileType c,cpp,arduino,cuda setlocal cinoptions=>1s,(-1s
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
" html,php {{{
autocmd FileType php,html setlocal autoindent
autocmd FileType php,html setlocal smartindent
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
" autocmd FileType c setlocal omnifunc=ccomplete#Complete
" autocmd FileType cpp setlocal omnifunc=ccomplete#Complete
" autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
" autocmd FileType java setlocal omnifunc=javacomplete#Complete
" autocmd FileType python setlocal omnifunc=python2complete#Complete
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
" end line semicolon ; {{{
autocmd FileType c,cpp,cuda,arduino,objc,objcpp nnoremap ; $a;
autocmd FileType java,javascript,css,html,matlab,php,perl,typescript nnoremap ; $a;
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
\   '-I' . $HOME . '/.platformio/packages/framework-simba/src',
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
\   '-I/usr/include/eigen3',
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
\   '-I./build/clang/include',
\	'-I' . $HOME . '/.platformio/packages/framework-arduinoavr/cores/arduino',
\	'-I' . $HOME . '/.platformio/packages/framework-arduinostm32/STM32F1/cores/maple',
\	'-I' . $HOME . '/.platformio/packages/framework-arduinostm32/STM32F4/cores/maple',
\	'-I' . $HOME . '/.platformio/packages/framework-mbed',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f1/Drivers/STM32F1xx_HAL_Driver/Inc',
\	'-I' . $HOME . '/.platformio/packages/framework-stm32cube/f4/Drivers/STM32F4xx_HAL_Driver/Inc',
\	'-I' . $HOME . '/.platformio/packages/framework-arduino',
\	'-I' . $HOME . '/.platformio/packages/framework-arduinostm32',
\	'-I' . $HOME . '/.platformio/packages/framework-arduino/libraries/__cores__/arduino/Wire',
\	'-I' . $HOME . '/.platformio/packages/framework-arduino/libraries/__cores__/arduino/SPI',
\	'-I' . $HOME . '/.platformio/packages/framework-arduino/libraries/__cores__/arduino/SoftwareSerial',
\	'-I' . $HOME . '/.platformio/packages/framework-arduino/libraries/__cores__/arduino/HID',
\	'-I' . $HOME . '/.platformio/packages/framework-arduino/libraries/__cores__/arduino/EEPROM',
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
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_python_flake8_args = [
\   '--ignore=W291,W391,E111,E113,E114,E121,E125,E127,E128,E221,E225,E226,E231,E302,E303,W391,E501,E701,F401'
\]
" }}}
" {{{ javascript maker
let g:neomake_javascript_enabled_makers = ['eslint']
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
let g:deoplete#max_list = 10000
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_refresh_delay = 10
call deoplete#custom#option('ignore_sources', {'_': ['around']})

" deoplete-cpp {{{
let g:deoplete#sources#cpp#include_paths = [
\   '/usr/include/eigen3',
\   '/usr/include/pcl-1.7',
\   '/usr/include/mpi',
\   '/usr/include/libusb-1.0',
\   '/usr/lib/jvm/java-8-oracle/include',
\   '/usr/lib/jvm/java-8-oracle/include/linux',
\   '/usr/local/lib/python2.7/dist-packages/tensorflow/include',
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
" neosnippet settings {{{
" {{{ options
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#snippets_directory = '~/.config/nvim/bundle/snippets.vim/snippets'
" }}}
" }}}
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
" vim-ros setting {{{
let g:ros_catkin_workspace = '~/catkin_kinetic'
" }}}
" clang-format settings {{{
let g:clang_format#code_style = 'google'
let g:clang_format#filetype_style_options = {
\   'cpp' : {
\     'Standard': 'C++11',
\     'ColumnLimit': 80,
\   },
\   'javascript' : {
\     'ColumnLimit': 80,
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
inoremap <silent><expr> <CR> pumvisible() ? "\<C-x>\<CR>" : "<CR>"

function TabFunction()
  if neosnippet#expandable_or_jumpable()
    return "\<Plug>(neosnippet_expand_or_jump)"
  elseif pumvisible()
    return "\<C-n>\<C-y>"
  endif
  return "\<Tab>"
endfunction
imap <silent><expr> <Tab> TabFunction()

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

" commands
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

" function keys
nmap  <silent><F1>  :NERDTreeToggle .<CR>
imap  <F1>  <Esc>:NERDTreeToggle .<CR>
nmap  <silent><F2>  :GitGutterToggle<CR>
imap  <F2>  <Esc>:GitGutterToggle<CR>
nmap  <silent><F3>  :IndentLinesToggle<CR>
imap  <F3>  <Esc>:IndentLinesToggle<CR>
" a.vim shortcut
nmap  <leader><leader>a :A<CR>
"" }}}
