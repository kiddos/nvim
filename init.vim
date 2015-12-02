if has('vim_starting')
	set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.config/nvim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Bundles:
" syntax
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'ap/vim-css-color'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'moll/vim-node'
NeoBundle 'elzr/vim-json'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-rails'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'tpope/vim-haml'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'sgeb/vim-matlab'
NeoBundle 'othree/html5.vim'
NeoBundle 'kiddos/vim-vhdl'
NeoBundle 'burnettk/vim-angular'
NeoBundle 'Valloric/MatchTagAlways'
NeoBundle 'ashisha/image.vim'
NeoBundle 'octol/vim-cpp-enhanced-highlight'

" color scheme
NeoBundle 'kiddos/malokai'
NeoBundle 'ternjs/tern_for_vim'

" code completion
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'ternjs/tern_for_vim'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'shawncplus/phpcomplete.vim'
NeoBundle 'artur-shaik/vim-javacomplete2'

" git
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'

" utils
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'bling/vim-airline'
NeoBundle 'benekastah/neomake'
NeoBundle 'garbas/vim-snipmate'
NeoBundle 'godlygeek/tabular'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'suan/vim-instant-markdown'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'kien/ctrlp.vim'

" libs
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"" omni completeion --------------------------------------------------{{{
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType cpp setlocal ofu=ccomplete#Complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType python setlocal omnifunc=python3complete#Complete
autocmd FileType php setlocal ofu=phpcomplete#CompletePHP
autocmd FileType html,xhtml setlocal ofu=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby,eruby setlocal ofu=rubycomplete#Complete
autocmd FileType javascript setlocal omnifunc=tern#Complete
"" -------------------------------------------------------------------}}}

"" coding settings ---------------------------------------------------{{{
set autoindent
set nosmartindent
set complete=.,w,b,u,U,t,k
set completeopt=menu
set number
autocmd FileType c,cpp,objc,javascript,php setlocal foldmarker={,}
autocmd FileType c,cpp,objc,xml,html,css,javascript,ruby,php,java,python set foldlevel=20
setlocal foldmethod=marker
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR
"" -------------------------------------------------------------------}}}

"" buffer settings ---------------------------------------------------{{{
set autoread
set backupdir=.,~/.vimtmp,/tmp
set confirm
set cscopepathcomp=2
set directory=.,~/.vimtmp,/tmp
set hidden
set icon
set iconstring=vim
set nowritebackup
autocmd VimEnter,BufRead,BufNewFile *.m set filetype=objc
autocmd VimEnter,BufRead,BufNewFile *.h set filetype=cpp
autocmd VimEnter,BufRead,BufNewFile *.ejs set filetype=html
autocmd VimEnter,BufRead,BufNewFile *.pro set filetype=make
"" -------------------------------------------------------------------}}}

"" editing settings --------------------------------------------------{{{
set altkeymap
set ambiwidth=double
set backspace=indent,eol,start
set clipboard=unnamedplus
set cursorcolumn
set cursorline
set encoding=utf-8
set ignorecase
set incsearch
set linebreak
set shiftround
"set showbreak=+++\
set smartcase
" general indenting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
" python indenting
autocmd FileType python setlocal tabstop=8
autocmd FileType python setlocal expandtab
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal modeline
" matlab indenting
autocmd FileType matlab setlocal tabstop=4
autocmd FileType matlab setlocal expandtab
autocmd FileType matlab setlocal softtabstop=3
autocmd FileType matlab setlocal shiftwidth=3
autocmd FileType matlab setlocal modeline
" indenting html
autocmd FileType html setlocal tabstop=4
autocmd FileType html setlocal expandtab
autocmd FileType html setlocal softtabstop=2
autocmd FileType html setlocal shiftwidth=2
autocmd FileType html setlocal modeline
" indenting javascript
autocmd FileType javascript setlocal tabstop=4
autocmd FileType javascript setlocal expandtab
autocmd FileType javascript setlocal softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType javascript setlocal modeline
" indenting css
autocmd FileType css setlocal tabstop=4
autocmd FileType css setlocal expandtab
autocmd FileType css setlocal softtabstop=2
autocmd FileType css setlocal shiftwidth=2
autocmd FileType css setlocal modeline

set timeoutlen=1000 ttimeoutlen=0
set whichwrap+=<,>,b,s,[,],~
set wrap
"" --------------------------------------------------------------------}}}

"" window settings ---------------------------------------------------{{{
set cmdheight=2
set cmdwinheight=6
" set columns=100
" set lines=36
set relativenumber
set fillchars=stl:\ ,stlnc:-,vert:\|,fold:-,diff:-
set langmenu=en_US.UTF-8
set laststatus=2
" gives the number of lines that is checked for set commands.
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
"" --------------------------------------------------------------------}}}

"" screen size --------------------------------------------------------{{{
if has("gui_running")
	set lines=999
	set columns=999
endif

"" GUI settings
if has("unix")
	set guifont=Ubuntu\ Mono\ 13
else
	set guifont=Consolas:h12
endif
"" --------------------------------------------------------------------}}}

"" Custom key mappings ------------------------------------------------{{{
let mapleader=","

" copy, cut, paste, save
inoremap	<C-C>	<Esc>yy
inoremap	<C-X>	<Esc>cc
inoremap	<C-V>	<Esc>pa

"" typo
command!	WQ	wq
command!	Wq	wq
command!	W	w
command!	Q	q
command!	Qa	qa
command!	QA	qa

noremap		L	l
noremap		K	k
noremap		J	j
noremap		H	h

"" moving between splits
nnoremap	<C-H>	<C-W><C-H>
nnoremap	<C-J>	<C-W><C-J>
nnoremap	<C-K>	<C-W><C-K>
nnoremap	<C-L>	<C-W><C-L>

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

"" end line semicolon ;
autocmd		FileType	c		nnoremap ; $a;
autocmd		FileType	cpp		nnoremap ; $a;
autocmd		FileType	objc	nnoremap ; $a;
autocmd		FileType	java	nnoremap ; $a;
autocmd		FileType	php		nnoremap ; $a;
autocmd		FileType	html	nnoremap ; $a;
autocmd		FileType	css		nnoremap ; $a;
autocmd		FileType	javascript nnoremap ; $a;
autocmd		FileType	matlab	nnoremap ; $a;

"" jump window
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
"inoremap <C-D>	<C-X><C-O><C-P>
inoremap <C-D>	<C-X><C-U>
"" --------------------------------------------------------------------}}}

"" color settings {{{
set background=dark
syntax enable
syntax on
set t_Co=256
colorscheme malokai
" }}}

"" javascript settings
let b:javascript_fold = 1

"" keybindings ---------------------------------------------------------{{{
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

nmap	<silent><F1>	:set columns=999<CR>:set lines=66<CR>:redraw<CR>
nmap	<silent><F2>	:NERDTreeToggle .<CR>
nmap	<F3>			:TagbarToggle<CR>
nmap	<F4>			:GitGutterToggle<CR>
nmap	<silent><F5>	:call Test_webpage()<CR>
nmap	<silent><F6>	:setlocal spell!<CR>
nmap	<silent><F7>	:call Toggle_ft_m()<CR><CR>
nmap	<silent><F8>	:call OutlineToggle()<CR>

nmap	<leader><space>		:Tabularize / <CR>
nmap	<leader>"			:Tabularize /"[^"]*"<CR>
nmap	<leader>(			:Tabularize /(.*)<CR>
nmap	<leader>=			:Tabularize /= <CR>
nmap	<leader>a			:AV<CR>
nmap	<leader>f			za
nmap	<leader>F			zA

nmap	<leader>d	:YcmForceCompileAndDiagnostics<CR>
nmap	<leader>s	:YcmShowDetailedDiagnostic<CR>
nmap	<leader>t	:YcmCompleter GetType<CR>
nmap	<leader>p	:YcmCompleter GetParent<CR>
nmap	<leader>r	:YcmRestartServer<CR>
nmap	<leader><Up>	:YcmCompleter GoToDeclaration<CR>
nmap	<leader><Down>	:YcmCompleter GoToDefinition<CR>

nmap	J	<C-D>
nmap	K	<C-U>
nmap	H	<C-E>
nmap	L	<C-Y>

imap	<C-F> <C-R><Tab><C-P>
"" ---------------------------------------------------------------------}}}

"" AutoClose options {{{
let g:AutoClosePairs_add = "[] '' "
let g:AutoClosePreserveDotReg = 0
"" }}}

"" vim-airline configuration {{{
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline_detect_crypt = 1
let g:airline_detect_iminsert = 1
let g:airline_inactive_collapse = 1
let g:airline_theme = 'powerlineish'
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

"" syntasitc settings {{{
autocmd VimEnter * silent! :SyntasticToggleMode
autocmd	BufWritePost * silent! :SyntasticCheck
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

highlight	SyntasticErrorSign	cterm=BOLD	ctermfg=253	ctermbg=124	guifg=white	guibg=red
highlight	SyntasticError		cterm=BOLD	ctermfg=253	ctermbg=236	guibg=#2f0000
highlight	SyntasticErrorLine	cterm=BOLD	ctermfg=253	ctermbg=236	guibg=#2f0000
"
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
let g:syntastic_c_compiler_options = "-Wall -g -O3 -fopenmp -fmax-errors=10 -pthread -std=c99"
let g:syntastic_c_include_dirs = ['/usr/include/ImageMagick/']
" c++ options
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler_options = "-Wall -g -O3 -fopenmp -std=c++11 -pthread -fPIC"
let g:syntastic_cpp_include_dirs = ['.',
\		'/usr/include/ImageMagick/',
\		'/opt/Qt5.5.0/5.5/gcc_64/include',
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
\		'/usr/include/GNUstep/',
\		'/usr/include/GNUstep/AppKit',
\		'/usr/include/GNUstep/Cocoa',
\		'/usr/include/GNUstep/Cynthiune',
\		'/usr/include/GNUstep/DBKit',
\		'/usr/include/GNUstep/Foundation',
\		'/usr/include/GNUstep/Frameworks',
\		'/usr/include/GNUstep/FSNode',
\		'/usr/include/GNUstep/GNUMail',
\		'/usr/include/GNUstep/gnustep',
\		'/usr/include/GNUstep/GNUstepBase',
\		'/usr/include/GNUstep/GNUstepGUI',
\		'/usr/include/GNUstep/GormCore',
\		'/usr/include/GNUstep/GormObjCHeaderParser',
\		'/usr/include/GNUstep/GormPrefs',
\		'/usr/include/GNUstep/Inspector',
\		'/usr/include/GNUstep/InterfaceBuilder',
\		'/usr/include/GNUstep/Operation',
\		'/usr/include/GNUstep/PreferencePanes',
\		'/usr/include/GNUstep/ProjectCenter',
\		'/usr/include/GNUstep/Renaissance',
\		'/usr/include/GNUstep/TalkSoupBundles',
\		'.',
\		'..',
\		'./include',
\		'../include']
" objc options
let g:syntastic_objc_compiler_options = "-Wall `gnustep-config --objc-flags` `gnustep-config --objc-libs` "
"let g:syntastic_objc_compiler = "clang"
"let g:syntastic_objc_compiler_options += "-DGNU_GUI_LIBRARY=1 -DGNU_RUNTIME=1 "
"let g:syntastic_objc_compiler_options += "-DGNUSTEP_BASE_LIBRARY=1 -fno-strict-aliasing "
"let g:syntastic_objc_compiler_options += "-fexceptions -fobjc-exceptions "
"let g:syntastic_objc_compiler_options += "-D_NATIVE_OBJC_EXCEPTIONS -pthread -fPIC "
"let g:syntastic_objc_compiler_options += "-Wall -DGSWARN -DGSDIAGNOSE -Wno-import -g -O2 "
"let g:syntastic_objc_compiler_options += "-fgnu-runtime -fconstant-string-class=NSConstantString"
"let g:syntastic_objc_include_dirs = ['/usr/include/GNUstep']
" python options
let g:syntastic_python_python_exec = '/usr/bin/python'
let g:syntastic_python_checkers = ['flake8', 'python']
let g:syntastic_python_flake8_args='--ignore=E501,E225,E302,E303,W391'
" html options
let g:syntastic_html_checkers = ['jshint']
" javascript options
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_closurecompiler_path = '~/Web/tools/google-closure-compiler.jar'
" jade options
let g:syntastic_jade_checkers = ['jade-lint']
"" --------------------------------------------------------------------}}}

"" YouCompleteMe Options ----------------------------------------------{{{
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
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1

let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_log_level = 'debug'
let g:ycm_auto_start_csharp_server = 0
let g:ycm_auto_stop_csharp_server = 0
let g:ycm_csharp_server_port = 1

let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_key_list_select_completion = []
let g:ycm_key_list_previous_completion = []
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_detailed_diagnostics = '<leader>d'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_cache_omnifunc = 0
let g:ycm_use_ultisnips_completer = 1
let g:ycm_disable_for_files_larger_than_kb = 8192
let g:ycm_semantic_triggers =  {
\   'c' : ['->', '.', '<', '#', '>', '_', '*', '&', '(', ')', '\\'],
\   'objc' : ['->', '.', '<', '#'],
\   'cpp' : ['->', '.', '::', '#', '<', '>', '_', '*', '&', '\b', '(', ')'],
\   'objcpp' : ['->', '.', '::', '#'],
\   'java' : ['.'],
\   'ocaml' : ['.', '#'],
\   'perl' : ['->'],
\	'css' : [':'],
\   'php' : ['.', '->', '::', '_', '$', '[', ']'],
\   'javascript' : ['.', "'", '(', '"'],
\   'cs,d,vim,python,perl6,scala,vb,elixir,go' : ['.', '(', ')'],
\	'html' : ['"', '<', '/', '=', '"', '>'],
\   'ruby' : ['.', '::'],
\   'lua' : ['.', ':'],
\   'erlang' : [':']
\ }
"autocmd CursorMovedI c,cpp,java,python,ruby,eruby,html,css,php,javascript,xml call feedkeys("\<C-X><C-O><C-P>")
"autocmd CursorMovedI c,cpp,java,python,ruby,eruby,html,css,php,javascript,xml call feedkeys("\<C-Space>")

"" --------------------------------------------------------------------}}}

