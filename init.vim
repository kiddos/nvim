if has('vim_starting')
	set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.config/nvim/bundle/'))
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" Bundles:
" general utilities plugins {{{
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'bling/vim-airline'
NeoBundle 'benekastah/neomake'
NeoBundle 'garbas/vim-snipmate'
NeoBundle 'godlygeek/tabular'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-projectionist'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'ryanoasis/vim-devicons'
NeoBundle 'mhinz/vim-startify'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'ashisha/image.vim'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'mbbill/undotree'
NeoBundle 'kannokanno/previm'
NeoBundle 'arecarn/crunch.vim'
NeoBundle 'arecarn/selection.vim'
NeoBundle 'chrisbra/csv.vim'
" }}}
" git {{{
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'gregsexton/gitv'
" }}}
" tmux {{{
NeoBundle 'erikw/tmux-powerline'
NeoBundle 'edkolev/tmuxline.vim'
" }}}
" color scheme {{{
NeoBundle 'kiddos/malokai'
NeoBundle 'altercation/vim-colors-solarized'
" }}}
" libs {{{
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'
" }}}
" language specific
" C family/vhdl {{{
NeoBundle 'octol/vim-cpp-enhanced-highlight'
NeoBundle 'OrangeT/vim-csharp'
NeoBundle 'kiddos/a.vim'
NeoBundle 'vhda/verilog_systemverilog.vim'
NeoBundle 'kiddos/vim-vhdl'
NeoBundle 'Valloric/YouCompleteMe', {
	\ 'build': {
		\ 'unix': './install.sh --clang-completer',
	\ }
\ }
" }}}
" Java {{{
NeoBundle 'artur-shaik/vim-javacomplete2'
NeoBundle 'vim-scripts/java_getset.vim'
NeoBundle 'krisajenkins/vim-java-sql'
" }}}
" Matlab/Octave/R {{{
NeoBundle 'vim-scripts/octave.vim--'
NeoBundle 'jalvesaq/Nvim-R'
" }}}
" Web syntax {{{
" html/jade/ejs/jst
NeoBundle 'othree/html5.vim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'Valloric/MatchTagAlways'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'briancollins/vim-jst'
NeoBundle 'burnettk/vim-angular'
NeoBundle 'coachshea/jade-vim'
NeoBundle 'zeekay/vim-html2jade'
" css/less/stylus/sass/scss
NeoBundle 'ap/vim-css-color'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'groenewege/vim-less'
NeoBundle '1995eaton/vim-better-css-completion'
" javascript
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'ternjs/tern_for_vim'
NeoBundle 'nono/jquery.vim'
NeoBundle 'moll/vim-node'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'elzr/vim-json'
" rails
NeoBundle 'tpope/vim-rails'
NeoBundle 'lambdatoast/elm.vim'
" php
NeoBundle 'shawncplus/phpcomplete.vim'
" }}}

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
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
"autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType javascript setlocal omnifunc=tern#Complete
" }}}
"" coding settings {{{
set autoindent
set nosmartindent
set complete=.,w,b,u,U,t,k
set completeopt=menu
autocmd FileType r setlocal completeopt=menu,preview
set number
autocmd FileType c,cpp,objc,javascript,php setlocal foldmarker={,}
autocmd FileType c,cpp,objc,xml,html,css,javascript,ruby,php,java,python set foldlevel=20
setlocal foldmethod=marker
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR
let b:javascript_fold = 1
let R_show_args = 1
let b:javagetset_getterTemplate =
\ "\n" .
\ "%modifiers% %type% %funcname%() {\n" .
\ "\treturn %varname%;\n" .
\ "}"
let b:javagetset_setterTemplate =
\ "\n" .
\ "%modifiers% void %funcname%(%type% %varname%) {\n" .
\ "\tthis.%varname% = %varname%;\n" .
\ "}"
" }}}
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
autocmd VimEnter,BufRead,BufNewFile *.m set filetype=matlab
autocmd VimEnter,BufRead,BufNewFile *.h set filetype=cpp
autocmd VimEnter,BufRead,BufNewFile *.ejs set filetype=html
autocmd VimEnter,BufRead,BufNewFile *.pro set filetype=make
" }}}
"" editing settings {{{
set altkeymap
set backspace=indent,eol,start
set clipboard=unnamedplus
set encoding=utf-8
set ignorecase
set incsearch
set linebreak
set shiftround
set smartcase
" general indenting
set tabstop=4
set expandtab
set softtabstop=2
set shiftwidth=2
set modeline
" python indenting
autocmd FileType python setlocal tabstop=8
autocmd FileType python setlocal expandtab
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal modeline
set timeoutlen=1000 ttimeoutlen=0
set whichwrap+=<,>,b,s,[,],~
set wrap
" }}}
"" window settings {{{
set cmdheight=1
set cmdwinheight=6
set relativenumber
set fillchars=stl:\ ,stlnc:-,vert:\|,fold:-,diff:-
set langmenu=en_US.UTF-8
set laststatus=2
set modeline
set modelines=30
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
" }}}
"" Custom key mappings {{{
let mapleader=","
" copy, cut, paste, save
inoremap  <C-C> <Esc>yy
inoremap  <C-X>	<Esc>cc
inoremap  <C-V>	<Esc>pa
"" typo
command!  WQ  wq
command!  Wq  wq
command!  W	  w
command!  Q	  q
command!  Qa  qa
command!  QA  qa
noremap	  L	l
noremap	  K	k
noremap	  J	j
noremap	  H	h
"" moving between splits
nnoremap  <C-H>	<C-W><C-H>
nnoremap  <C-J>	<C-W><C-J>
nnoremap  <C-K>	<C-W><C-K>
nnoremap  <C-L>	<C-W><C-L>
"" Tab switching
nmap	<leader>1	1gt
nmap	<leader>2	2gt
nmap	<leader>3	3gt
nmap	<leader>4	4gt
nmap	<leader>5	5gt
nmap	<leader>6	6gt
nmap	<leader>7	7gt
nmap	<leader>8	8gt
nmap	<leader>9	9gt
" split/close tab
nmap	<leader><Tab>		:tabedit<CR>
nmap	<leader>v			:vs<CR>
nmap	<leader>q			:q<CR>
nmap	<leader>Q			:q<CR>
" buffer scrolling in insert mode
inoremap	<C-E>	<Esc><C-E>a
inoremap	<C-W>	<Esc><C-Y>a
" end line semicolon ;
autocmd		FileType	c		nnoremap ; $a;
autocmd		FileType	cpp		nnoremap ; $a;
autocmd		FileType	objc	nnoremap ; $a;
autocmd		FileType	java	nnoremap ; $a;
autocmd		FileType	php		nnoremap ; $a;
autocmd		FileType	html	nnoremap ; $a;
autocmd		FileType	css		nnoremap ; $a;
autocmd		FileType	javascript nnoremap ; $a;
autocmd		FileType	matlab	nnoremap ; $a;
" jump window
inoremap	<C-]>	<Esc><C-W><C-]>
nnoremap	<C-]>	<C-W><C-]>
"" Omni Complete
inoremap <expr>	<CR>		pumvisible() ? "\<C-N><C-Y>" : "\<CR>"
inoremap <expr>	<Down>		pumvisible() ? "\<C-N>" : "\<Down>"
inoremap <expr>	<Up>		pumvisible() ? "\<C-P>" : "\<Up>"
inoremap <expr>	<C-J>		pumvisible() ? "\<C-N>" : "\<Esc><C-W><C-J>"
inoremap <expr>	<C-K>		pumvisible() ? "\<C-P>" : "\<Esc><C-W><C-K>"
inoremap <expr> <PageDown>	pumvisible() ? "\<PageDown>\<C-P>\<C-N>" : "\<PageDown>"
inoremap <expr> <PageUp>	pumvisible() ? "\<PageUp>\<C-P>\<C-N>" : "\<PageUp>"
" }}}
"" color settings {{{
syntax enable
syntax on
"set cursorcolumn
set cursorline
set t_Co=256
set background=dark
"set background=light
colorscheme malokai
"colorscheme solarized
" }}}
"" vim-airline configuration {{{
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline_detect_crypt = 1
let g:airline_detect_iminsert = 1
let g:airline_inactive_collapse = 1
let g:airline_theme = 'term'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '◀'
"let g:airline_left_sep = '>'
"let g:airline_right_sep = '<'
"let g:airline_left_sep = '⊃'
"let g:airline_right_sep = '⊂'
"let g:airline_left_sep = '≻'
"let g:airline_right_sep = '≺'
"let g:airline_left_sep = '⟩'
"let g:airline_right_sep = '⟨'
"let g:airline_left_sep = '◗'
"let g:airline_right_sep = '◖'
"let g:airline_left_sep = '⇒'
"let g:airline_right_sep = '⇐'
"let g:airline_left_sep = '⇉'
"let g:airline_right_sep = '⇇'
"let g:airline_left_sep = '↣'
"let g:airline_right_sep = '↢'
"let g:airline_left_sep = '→'
"let g:airline_right_sep = '←'
"let g:airline_left_sep = '»'
"let g:airline_right_sep = '«'
"let g:airline_left_sep = '⌦  '
"let g:airline_right_sep = '⌫  '
let g:airline_left_sep = '⊳'
let g:airline_right_sep = '⊲ '
"let g:airline_right_alt_sep = ''
"let g:airline_left_alt_sep = '⌲'
"let g:airline_right_alt_sep = '☄ '
"let g:airline_left_alt_sep = '☃ '
"let g:airline_right_alt_sep = '☂ '
"let g:airline_left_alt_sep = '☁ '
"let g:airline_right_alt_sep = '☬ '
"let g:airline_left_alt_sep = '✯ '
let g:airline_right_alt_sep = '⌘ '
let g:airline_left_alt_sep = ''
"let g:airline_symbols.crypt = '☢'
"let g:airline_symbols.crypt = '☣'
let g:airline_symbols.crypt = '☠'
"let g:airline_symbols.linenr = ''
"let g:airline_symbols.linenr = '⌮'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.linenr = '⇳ '
let g:airline_symbols.linenr = '⇵ '
"let g:airline_symbols.branch = '☯'
"let g:airline_symbols.branch = '☻'
"let g:airline_symbols.branch = '☺'
"let g:airline_symbols.branch = '☈ '
let g:airline_symbols.branch = '⎇ '
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = '℘'
let g:airline_symbols.paste = 'ℙ '
"let g:airline_symbols.readonly = ''
let g:airline_symbols.readonly = 'ℜ '
"let g:airline_symbols.whitespace = 'Ξ'
"let g:airline_symbols.whitespace = '⇆'
let g:airline_symbols.whitespace = '⌨  '
"" }}}
"" GitGutter options {{{
autocmd VimEnter * silent! :GitGutterDisable
"" }}}
"" syntasitc settings {{{
autocmd VimEnter * silent! :SyntasticToggleMode
autocmd	BufWritePost * silent! :SyntasticCheck
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

highlight	SyntasticErrorSign	cterm=BOLD	ctermfg=253	ctermbg=124	guifg=white	guibg=red
highlight	SyntasticError		cterm=BOLD	ctermfg=253	ctermbg=236	guibg=#2f0000
highlight	SyntasticErrorLine	cterm=BOLD	ctermfg=253	ctermbg=236	guibg=#2f0000

" general options
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 6
let g:syntastic_auto_jump = 0

" c options
let g:syntastic_c_check_header = 1
let g:syntastic_c_compiler_options = "-Wall -g -O3 -fopenmp -std=c99 -pthread -fPIC -fmax-errors=10"
let g:syntastic_c_include_dirs = ['/usr/include/ImageMagick/']
" c++ options
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler_options = "-Wall -g -O3 -fopenmp -std=c++11 -pthread -fPIC"
let g:syntastic_cpp_include_dirs = [
\		'/usr/include/ImageMagick/',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/Enginio',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DCore',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DInput',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DQuick',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DQuickRenderer',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/Qt3DRenderer',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtBluetooth',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtCLucene',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtConcurrent',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtCore',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtDBus',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtDeclarative',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtDesigner',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtDesignerComponents',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtGui',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtHelp',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtLocation',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtMultimedia',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtMultimediaQuick_p',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtMultimediaWidgets',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtNetwork',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtNfc',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtOpenGL',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtOpenGLExtensions',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtPlatformHeaders',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtPlatformSupport',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtPositioning',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtPrintSupport',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtQml',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtQmlDevTools',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtQuick',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtQuickParticles',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtQuickTest',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtQuickWidgets',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtScript',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtScriptTools',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtSensors',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtSerialPort',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtSql',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtSvg',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtTest',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtUiPlugin',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtUiTools',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebChannel',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebEngine',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebEngineWidgets',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebKit',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebKitWidgets',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebSockets',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtWebView',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtWidgets',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtX11Extras',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtXml',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtXmlPatterns',
\		'/opt/Qt5.5.0/5.5/gcc_64/include/QtZlib',
\		'.',
\		'..',
\		'./include',
\		'../include']
" objc options
let g:syntastic_objc_compiler_options = "-Wall -g -O3 -fPIC `gnustep-config --objc-flags` `gnustep-config --objc-libs` "
"let g:syntastic_objc_compiler = "clang"
"let g:syntastic_objc_compiler_options += "-DGNU_GUI_LIBRARY=1 -DGNU_RUNTIME=1 "
"let g:syntastic_objc_compiler_options += "-DGNUSTEP_BASE_LIBRARY=1 -fno-strict-aliasing "
"let g:syntastic_objc_compiler_options += "-fexceptions -fobjc-exceptions "
"let g:syntastic_objc_compiler_options += "-D_NATIVE_OBJC_EXCEPTIONS -pthread -fPIC "
"let g:syntastic_objc_compiler_options += "-Wall -DGSWARN -DGSDIAGNOSE -Wno-import -g -O2 "
"let g:syntastic_objc_compiler_options += "-fgnu-runtime -fconstant-string-class=NSConstantString"
let g:syntastic_objc_include_dirs = ['/usr/include/GNUstep']
" python options
let g:syntastic_python_python_exec = '/usr/bin/python'
let g:syntastic_python_checkers = ['flake8', 'python']
let g:syntastic_python_flake8_args='--ignore=E501,E225,E302,E303,W391,E226,E231,E701'
" html options
let g:syntastic_html_checkers = ['jshint']
" javascript options
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_closurecompiler_path = '~/Web/tools/google-closure-compiler.jar'
" jade options
let g:syntastic_jade_checkers = ['jade-lint']
" R options
let g:syntastic_enable_r_svtools_checker = 1
" }}}
"" YouCompleteMe Options {{{
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_auto_trigger = 1
let g:ycm_min_num_identifier_candidate_chars = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_echo_current_diagnostic = 0
let g:ycm_always_populate_location_list = 0

let g:ycm_allow_changing_updatetime = 0
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_string = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_seed_identifiers_with_syntax = 1

let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_log_level = 'debug'
let g:ycm_auto_start_csharp_server = 1
let g:ycm_auto_stop_csharp_server = 1
let g:ycm_csharp_server_port = 0

let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_key_list_select_completion = []
let g:ycm_key_list_previous_completion = []
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_detailed_diagnostics = '<leader>d'
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_filepath_completion_use_working_dir = 0
let g:ycm_cache_omnifunc = 0
let g:ycm_use_ultisnips_completer = 0
let g:ycm_disable_for_files_larger_than_kb = 16000
let g:ycm_semantic_triggers =  {
\   'c' : ['->', '.', '<', '#'],
\   'objc' : ['->', '.', '<', '#'],
\   'cpp' : ['->', '.', '::', '#', '<'],
\   'objcpp' : ['->', '.', '::', '#', '<'],
\   'java' : ['.'],
\   'ocaml' : ['.', '#'],
\   'perl' : ['->'],
\	'css' : [':'],
\   'php' : ['.', '->', '::', '_', '$', '['],
\   'javascript' : ['.', "'", '(', '"'],
\   'cs,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
\	'html' : ['"', '<', '/', '=', '"'],
\   'ruby' : ['.', '::'],
\   'lua' : ['.', ':'],
\   'erlang' : [':'],
\	'r' : ['$']
\ }
" }}}
"" vim-startify {{{
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
let g:startify_bookmarks = [ {'init': '  ~/.config/nvim/init.vim'}]
let g:startify_custom_header =
		\ map(split(system('tips.py | cowsay -f $(ls /usr/share/cowsay/cows | shuf -n 1 | cut -d. -f1)'), '\n'), '"   ". v:val') + ['']
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1
let g:startify_enable_special = 0
let g:startify_custom_footer = [
	\ '',
	\ '________   _______   ________  ___      ___ ___  _____ ______       ',
	\ '|\   ___  \|\  ___ \ |\   __  \|\  \    /  /|\  \|\   _ \  _   \    ',
	\ '\ \  \\ \  \ \   __/|\ \  \|\  \ \  \  /  / | \  \ \  \\\__\ \  \   ',
	\ ' \ \  \\ \  \ \  \_|/_\ \  \\\  \ \  \/  / / \ \  \ \  \\|__| \  \  ',
	\ '  \ \  \\ \  \ \  \_|\ \ \  \\\  \ \    / /   \ \  \ \  \    \ \  \ ',
	\ '   \ \__\\ \__\ \_______\ \_______\ \__/ /     \ \__\ \__\    \ \__\',
	\ '    \|__| \|__|\|_______|\|_______|\|__|/       \|__|\|__|     \|__|']
"" }}}
"" useful functions and keybindings {{{
function Toggle_ft_m()
  if &ft == "objc"
    execute ":setlocal ft=matlab"
  elseif &ft == "matlab"
    execute ":setlocal ft=objc"
  endif
endfunction

function! OutlineToggle()
  if (! exists ("b:outline_mode"))
    let b:outline_mode = 0
  endif
  if (b:outline_mode == 0)
    syn region myFold start="{" end="}" transparent fold
    syn sync fromstart
    set foldmethod=syntax
    silent! exec "%s/{{{/<<</"
    silent! exec "%s/}}}/>>>/"
    let b:outline_mode = 1
  else
    set foldmethod=marker
    silent! exec "%s/<<</{{{/"
    silent! exec "%s/>>>/}}}/"
    let b:outline_mode = 0
  endif
endfunction

function! Test_webpage()
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
    execute ":silent ! google-chrome " . this_file
    execute ":pclose!"
    execute ":redraw!"
  endif
endfunction

function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

function Compile_to_CSS()
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
  execute ":silent !".compiler." ".src." > ".target
endfunction

"autocmd BufWritePost *.less,*.sass,*.scss call Compile_to_CSS()
command! CompiletoCSS call Compile_to_CSS()
command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

nmap  <silent><F1>	:set columns=999<CR>:set lines=66<CR>:redraw<CR>
nmap  <silent><F2>	:NERDTreeToggle .<CR>
nmap  <silent><F3>	:TagbarToggle<CR>
nmap  <silent><F4>	:GitGutterToggle<CR>
nmap  <silent><F5>	:call Test_webpage()<CR>
nmap  <silent><F6>	:setlocal spell!<CR>
nmap  <silent><F7>	:call Toggle_ft_m()<CR><CR>
nmap  <silent><F8>	:call OutlineToggle()<CR>
nmap  <silent><F12>	:Crunch<CR>
" tabularize shortcut
nmap  <leader><space>   :Tabularize / <CR>
nmap  <leader>"			:Tabularize /"[^"]*"<CR>
nmap  <leader>(			:Tabularize /(.*)<CR>
nmap  <leader>=			:Tabularize /= <CR>
nmap  <leader>a			:AV<CR>
" large movement
nmap  J	<C-D>
nmap  K	<C-U>
nmap  H	<C-E>
nmap  L	<C-Y>
" some completion key bindings
imap  <C-F> <C-R><Tab><C-P>
imap  <C-D> <Plug>RCompleteArgs
" }}}
