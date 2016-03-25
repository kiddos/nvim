""
""	Author: Joseph Yu
""	Last Modified: 2016/3/21
""
if 0 | endif

set runtimepath^=~/.config/nvim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.config/nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
" color scheme {{{
NeoBundle 'kiddos/malokai'
NeoBundle 'kiddos/vim-after-syntax'
NeoBundle 'flazz/vim-colorschemes'
" }}}
" git {{{
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
NeoBundle 'gregsexton/gitv'
" }}}
" tmux {{{
NeoBundle 'erikw/tmux-powerline'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'benmills/vimux'
" }}}
" utility {{{
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', {'build': {'unix': 'make'}}
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-surround'
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
NeoBundle 'godlygeek/tabular'
NeoBundle 'kiddos/vim-snippets'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'terryma/vim-multiple-cursors'
" }}}
" deoplete {{{
NeoBundle 'Shougo/neco-vim'
NeoBundle 'Shougo/neoinclude.vim'
NeoBundle 'zchee/deoplete-clang'
NeoBundle 'carlitux/deoplete-ternjs'
NeoBundle 'zchee/deoplete-jedi'
" }}}
" libs {{{
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'
" }}}
" C family {{{
NeoBundle 'octol/vim-cpp-enhanced-highlight'
NeoBundle 'kiddos/a.vim'
NeoBundle 'jplaut/vim-arduino-ino'
NeoBundle 'beyondmarc/opengl.vim'
NeoBundle 'tikhomirov/vim-glsl'
" }}}
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
" Web {{{
NeoBundle 'othree/html5.vim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'briancollins/vim-jst'
NeoBundle 'evidens/vim-twig'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'nono/jquery.vim'
NeoBundle 'ap/vim-css-color'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'groenewege/vim-less'
NeoBundle 'moll/vim-node'
NeoBundle 'elzr/vim-json'
NeoBundle 'burnettk/vim-angular'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'lambdatoast/elm.vim'
NeoBundle 'zeekay/vim-html2jade'
NeoBundle 'coachshea/jade-vim'
NeoBundle 'ternjs/tern_for_vim'
NeoBundle 'shawncplus/phpcomplete.vim'
NeoBundle '1995eaton/vim-better-css-completion'
NeoBundle 'tpope/vim-markdown'
" }}}
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

"" code display setting {{{
set modeline
autocmd FileType c,cpp,objc,objcpp,cs set textwidth=80
autocmd FileType java,asm,vhdl,ruby,eruby,python,matlab,r set textwidth=80
autocmd FileType html,css,javascript,less,sass,scss,elm,,vim set textwidth=100
" code folding
autocmd FileType c,cpp,objc,objcpp,java,javascript,css,php setlocal foldmarker={,}
autocmd FileType c,cpp,objc,objcpp,java,javascript,css,php setlocal foldmethod=marker
autocmd FileType c,cpp,objc,objcpp,java,javascript,css,php setlocal foldlevel=3
autocmd FileType c,cpp,objc,objcpp,java,javascript,css,php normal zR
autocmd FileType html,xhtml,xml,haml,jst,python,ruby setlocal foldmethod=indent
autocmd FileType python,ruby setlocal foldlevel=3
autocmd FileType html,xhtml,xml,haml,hst setlocal foldlevel=20
autocmd FileType html,xhtml,xml,haml,jst,python,ruby normal zR
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldmarker={{{,}}}
autocmd FileType vim setlocal foldlevel=0
"" }}}
"" editing settings {{{
set altkeymap
set autoindent
set backspace=indent,eol,start
set clipboard=unnamedplus
set cindent
set encoding=utf-8
set ignorecase
set incsearch
set linebreak
set shiftround
set complete=.,w,b,u,U,t,k
set completeopt=menu
set number
set mouse=""
set expandtab
set tabstop=4
set softtabstop=2
set shiftwidth=2
set smartindent
" python indenting
autocmd FileType python setlocal expandtab
autocmd FileType python setlocal tabstop=8
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal shiftwidth=4
" make indenting
autocmd FileType make setlocal noexpandtab
autocmd FileType make setlocal tabstop=4
autocmd FileType make setlocal softtabstop=2
autocmd FileType make setlocal shiftwidth=2
" snippet indenting
autocmd FileType snippet setlocal noexpandtab
autocmd FileType snippet setlocal tabstop=8
autocmd FileType snippet setlocal softtabstop=4
autocmd FileType snippet setlocal shiftwidth=4
" solve zsh escap delay
set timeoutlen=1000 ttimeoutlen=0
"" }}}
"" buffer settings {{{
set autoread
set backupdir=.,~/.vimtmp,/tmp
set confirm
set cscopepathcomp=2
set directory=.,~/.vimtmp,/tmp
set hidden
set icon
set iconstring=vim
set nowritebackup
set formatoptions+=t
autocmd VimEnter,BufRead,BufNewFile *.m set filetype=matlab
autocmd VimEnter,BufRead,BufNewFile *.h set filetype=cpp
autocmd VimEnter,BufRead,BufNewFile *.ejs set filetype=html
autocmd VimEnter,BufRead,BufNewFile *.pro set filetype=make
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
" leader
let mapleader=","
let localleader="\\"
" copy, cut, paste, save
inoremap  <C-C>	<Esc>yy
inoremap  <C-X>	<Esc>cc
inoremap  <C-V>	<Esc>pa
"" typo
command!  WQ  wq
command!  Wq  wq
command!  W w
command!  Q q
command!  Qa  qa
command!  QA  qa
"" moving between splits
"nnoremap  <C-H>	<C-W><C-H>
"nnoremap  <C-J>	<C-W><C-J>
"nnoremap  <C-K>	<C-W><C-K>
"nnoremap  <C-L>	<C-W><C-L>
"" large movement
nmap J  <C-D>
nmap K  <C-U>
nmap H  <C-E>
nmap L  <C-Y>
"" Tab switching
nmap  <leader>1	1gt
nmap  <leader>2	2gt
nmap  <leader>3	3gt
nmap  <leader>4	4gt
nmap  <leader>5	5gt
nmap  <leader>6	6gt
nmap  <leader>7	7gt
nmap  <leader>8	8gt
nmap  <leader>9	9gt
" split/close tab
nmap <leader>q :q<CR>
nmap <leader>Q :q<CR>
nmap <leader>v :vsplit<CR>
"" jump window
inoremap  <C-]>	<Esc><C-W><C-]>
nnoremap  <C-]>	<C-W><C-]>
"" Omni Complete
inoremap <expr>	<CR>
\ (pumvisible() &&
\  matchstr(getline('.'), '\%'.col('.').'c.') != '}') ?
\ "\<C-N><C-Y>" : "\<CR>"
"" end line semicolon ;
autocmd	FileType  c	          nnoremap ; $a;
autocmd FileType  cpp         nnoremap ; $a;
autocmd	FileType  objc        nnoremap ; $a;
autocmd	FileType  java        nnoremap ; $a;
autocmd	FileType  matlab      nnoremap ; $a;
autocmd	FileType  php         nnoremap ; $a;
autocmd	FileType  html        nnoremap ; $a;
autocmd	FileType  css         nnoremap ; $a;
autocmd	FileType  javascript  nnoremap ; $a;
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
"" syntasitc settings {{{
autocmd VimEnter * silent! :SyntasticToggleMode
autocmd	BufWritePost * silent! :SyntasticCheck
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"" error highlight
highlight	SyntasticErrorSign	cterm=BOLD	ctermfg=253	ctermbg=124	guifg=white	guibg=red
highlight	SyntasticError		cterm=BOLD	ctermfg=253	ctermbg=236	guibg=#2f0000
highlight	SyntasticErrorLine	cterm=BOLD	ctermfg=253	ctermbg=236	guibg=#2f0000

"" general options
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 6
let g:syntastic_auto_jump = 0
"" language specific options
" c options {{{
let g:syntastic_c_check_header = 1
let g:syntastic_c_compiler_options = "-std=c99 -Wall -O3 -fopenmp -pthread -fPIC -DDEBUG"
let g:syntastic_c_include_dirs = [
\   '/usr/lib/gcc/x86_64-linux-gnu/4.8/include',
\   '/usr/src/linux-headers-4.2.8/include',
\   '/usr/src/linux-headers-4.2.8/kernel/',
\	'`pwd`',
\	'`pwd`/..',
\	'`pwd`/include',
\	'`pwd`/../include',
\   '`pwd`/src',
\   '`pwd`/../src',
\   ]
" }}}
" c++ options {{{
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler_options = "-Wall -g -O3 -fopenmp -std=c++11 -pthread -fPIC -DDEBUG -DQT_DEBUG"
let g:syntastic_cpp_include_dirs = [
\	'/opt/Qt5.5.0/5.5/gcc_64/include/',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/Enginio',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DCore',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DInput',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DQuick',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DQuickRenderer',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DRenderer',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtBluetooth',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtCLucene',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtConcurrent',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtCore',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtDBus',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtDeclarative',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtDesigner',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtDesignerComponents',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtGui',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtHelp',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtLocation',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtMultimedia',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtMultimediaQuick_p',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtMultimediaWidgets',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtNetwork',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtNfc',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtOpenGL',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtOpenGLExtensions',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtPlatformHeaders',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtPlatformSupport',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtPositioning',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtPrintSupport',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtQml',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtQmlDevTools',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtQuick',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtQuickParticles',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtQuickTest',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtQuickWidgets',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtScript',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtScriptTools',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtSensors',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtSerialPort',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtSql',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtSvg',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtTest',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtUiPlugin',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtUiTools',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebChannel',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebEngine',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebEngineWidgets',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebKit',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebKitWidgets',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebSockets',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebView',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtWidgets',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtX11Extras',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtXml',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtXmlPatterns',
\	'/opt/Qt5.5.0/5.5/gcc_64/include/QtZlib',
\   '/usr/lib/gcc/x86_64-linux-gnu/4.8/include',
\	'.',
\	'..',
\	'`pwd`/include',
\	'`pwd`/../include',
\   '`pwd`/src',
\   '`pwd`/../src',
\   ]
" }}}
" objc options {{{
let g:syntastic_objc_compiler_options = "-Wall -g -O3 -fPIC `gnustep-config --objc-flags` `gnustep-config --objc-libs` "
let g:syntastic_objc_include_dirs = [
\   '/usr/include/GNUstep',
\   '/usr/lib/gcc/x86_64-linux-gnu/4.8/include',
\	'.',
\	'..',
\	'./include',
\	'../include',
\   './src',
\   '../src',
\   ]
"let g:syntastic_objc_compiler = "clang"
"let g:syntastic_objc_compiler_options += "-DGNU_GUI_LIBRARY=1 -DGNU_RUNTIME=1 "
"let g:syntastic_objc_compiler_options += "-DGNUSTEP_BASE_LIBRARY=1 -fno-strict-aliasing "
"let g:syntastic_objc_compiler_options += "-fexceptions -fobjc-exceptions "
"let g:syntastic_objc_compiler_options += "-D_NATIVE_OBJC_EXCEPTIONS -pthread -fPIC "
"let g:syntastic_objc_compiler_options += "-Wall -DGSWARN -DGSDIAGNOSE -Wno-import -g -O2 "
"let g:syntastic_objc_compiler_options += "-fgnu-runtime -fconstant-string-class=NSConstantString"
let g:syntastic_objc_include_dirs = ['/usr/include/GNUstep']
" }}}
" python options {{{
let g:syntastic_python_python_exec = '/usr/bin/python'
let g:syntastic_python_checkers = ['flake8', 'python']
let g:syntastic_python_flake8_args='--ignore=E501,E225,E302,E303,W391,E226,E231,E701,E128,E113,E125,E127,E221'
" }}}
" html options {{{
let g:syntastic_html_checkers = ['jshint']
" }}}
" javascript options {{{
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_closurecompiler_path = '~/Web/tools/google-closure-compiler.jar'
" }}}
" jade options {{{
let g:syntastic_jade_checkers = ['jade-lint']
" }}}
" R options {{{
let g:syntastic_enable_r_svtools_checker = 1
" }}}
" }}}
"" Arduino setttings {{{
let g:vim_arduino_map_keys = 0
" }}}
"" indent line {{{
let g:indentLine_enabled = 0
"""}}}
"" GitGutter settings {{{
let g:gitgutter_enabled = 0
"" }}}
"" deoplete settings {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_debug = 1
let g:deoplete#max_list = 60
let g:deoplete#auto_complete_delay = 66
let g:deoplete#delimiters = []
let g:deoplete#_keyword_patterns = {
\  "c" : ['[a-zA-Z0-9$_]+'],
\  "cpp" : ['[a-zA-Z0-9$_]+'],
\}
let g:deoplete#omni_patterns = {
\  "c" : ['[a-zA-Z0-9$_]+'],
\  "cpp" : ['[a-zA-Z0-9$_]+'],
\}
"let g:deoplete#sources = {
"\  "cpp" : ['buffer', 'tag'],
"\}
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.6/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.6/include'
let g:deoplete#sources#clang#std#c = 'c11'
let g:deoplete#sources#clang#std#cpp = 'c++1z'
let g:deoplete#sources#clang#sort_algo = 'priority'
" }}}
"" startify settings {{{
let g:startify_list_order = [
      \ ['   My most recently used files in the current directory:'],
      \ 'dir',
      \ ['   My most recently used files:'],
      \ 'files',
      \ ['   Bookmarks:'],
      \ 'bookmarks',
      \ ['   Sessions:'],
      \ 'sessions',
      \ ]
let g:startify_files_number = 3
let g:startify_bookmarks = [
      \{'vimrc': '  ~/.vim/vimrc'},
      \{'nvimrc': '  ~/.config/nvim/init.vim'}]
let g:startify_custom_header =
      \ map(split(system('tips.py | cowsay -f $(ls /usr/share/cowsay/cows | shuf -n 1 | cut -d. -f1)'), '\n'), '"   ". v:val') + ['']
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1
let g:startify_enable_special = 0
"" }}}
"" useful functions and keybindings {{{
function! Toggle_filetype_dot_m()
  if &ft == "objc"
    execute ":setlocal ft=matlab"
  elseif &ft == "matlab"
    execute ":setlocal ft=objc"
  endif
endfunction

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

function! Compile_to_HTML()
  execute ":JadeWatch html vert"
endfunction

function! Compile_to_CSS()
  let src = expand("%:t")
  let target = expand("%:r") . ".css"
  let compiler = ""
  if &ft == "less"
    let compiler = "less"
  elseif &ft == "sass"
    let compiler = "sass"
  elseif &ft == "scss"
    let compiler = "scss"
  endif
  execute ":silent !".compiler." ".src." ".target
  execute ":redraw!"
endfunction

" tmux compile types of c++ program
function! Compile_CXX_Basic()
  let compiler = "gcc "
  if &ft == "cpp"
    let compiler = "g++ "
  endif
  let target = expand("%:r")
  let src = expand("%")
  let flags = " -g -DDEBUG "
  let standardlibs = "-lm "
  let libs = standardlibs
  call VimuxRunCommand("clear;echo \"compiling " . src . " ...\"")
  call VimuxRunCommand(compiler. "-o " . target . " " . src . flags . libs)
endfunction

function! Compile_CXX_OpenGL_GLFW3()
  let compiler = "gcc "
  if &ft == "cpp"
    let compiler = "g++ "
  endif
  let target = expand("%:r")
  let src = expand("%")
  let flags = " -g "
  let standardlibs = "-lm -lpthread -ldl "
  let gllibs = "-lglfw3 -lGLEW -lGL "
  let X11libs = "-lX11 -lXrandr -lXinerama -lXi -lXxf86vm -lXcursor "
  let libs = gllibs . X11libs . standardlibs
  call VimuxRunCommand("clear;echo \"compiling " . src . " ...\"")
  call VimuxRunCommand(compiler. "-o " . target . " " . src . flags . libs)
endfunction

function! Compile_CXX_ALLEGRO5()
  let compiler = "gcc "
  if &ft == "cpp"
    let compiler = "g++ "
  endif
  let target = expand("%:r")
  let src = expand("%")
  let flags = " -g "
  let standardlibs = "-lm "
  let al_core_libs = "-lallegro -lallegro_primitives -lallegro_dialog "
  let al_image_lib = "-lallegro_image "
  let al_font_lib = "-lallegro_font -lallegro_ttf "
  let al_audio_lib = "-lallegro_audio -lallegro_acodec "
  let libs = standardlibs . al_core_libs . al_image_lib . al_font_lib . al_audio_lib
  call VimuxRunCommand("clear;echo \"compiling " . src . " ...\"")
  call VimuxRunCommand(compiler. "-o " . target . " " . src . flags . libs)
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
" arduino commands
command! ArduinoCompile       call ArduinoCompile()
command! ArduinoDeploy        call ArduinoDeploy()
command! ArduinoSerialMonitor call ArduinoSerialMonitor()

" function keys
nmap  <silent><F1>  :NERDTreeToggle .<CR>
imap  <F1>  <Esc>:NERDTreeToggle .<CR>
nmap  <silent><F2>  :GitGutterToggle<CR>
imap  <F2>  <Esc>:GitGutterToggle<CR>
nmap  <silent><F3>  :IndentLinesToggle<CR>
imap  <F3>  <Esc>:IndentLinesToggle<CR>
nmap  <silent><F4>  :call Toggle_ft_m()<CR><CR>
imap  <F4>  <Esc>:call Toggle_ft_m()<CR><CR>
nmap  <silent><F5>  :call Quick_Compile()<CR>
imap  <F5>  <Esc>:call Quick_Compile()<CR>
nmap  <silent><F6>  :setlocal spell!<CR>
imap  <F6>  <Esc>:setlocal spell!<CR>
nmap  <silent><F7>  :TagbarToggle<CR>
imap  <F7>  <Esc>:TagbarToggle<CR>
" arduino mappings
nmap  <silent><F8>  :call ArduinoSerialMonitor()<CR>
imap  <F8>  <Esc>:call ArduinoSerialMonitor()<CR>
nmap  <silent><F9>  :call ArduinoDeploy()<CR>
imap  <F9>  <Esc>:call ArduinoDeploy()<CR>
" toggle .m file type (objc or matlab)
nmap  <silent><F10>  :call Toggle_filetype_dot_m()<CR>
imap  <F10>  <Esc>:call Toggle_filetype_dot_m()<CR>
" tabularize shortcut
nmap  <leader><space> :Tabularize / <CR>
nmap  <leader>"       :Tabularize /"[^"]*"<CR>
nmap  <leader>(       :Tabularize /(.*)<CR>
nmap  <leader>=       :Tabularize /= <CR>
" a.vim shortcut
nmap  <leader>a :A<CR>
nmap  <leader>s :AV<CR>
nmap  <leader>b :call Split_Vimux()<CR>
"" }}}
