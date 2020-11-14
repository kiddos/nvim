""
""	Author: Joseph Yu
""	Last Modified: 2020/07/11
""
if 0 | endif

set runtimepath^=~/.config/nvim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.config/nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
" color scheme {{{
NeoBundle 'kiddos/malokai.vim'
NeoBundle 'kaicataldo/material.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'morhetz/gruvbox'
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
NeoBundle 'mattn/emmet-vim'
NeoBundle 'dense-analysis/ale'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'ryanoasis/vim-devicons'
NeoBundle 'mhinz/vim-startify'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'kannokanno/previm'
NeoBundle 'arecarn/crunch.vim'
NeoBundle 'arecarn/selection.vim'
NeoBundle 'kiddos/snippets.vim'
NeoBundle 'kiddos/compile.vim'
NeoBundle 'kiddos/vim-ros'
NeoBundle 'kiddos/templates.vim'
NeoBundle 'rhysd/vim-clang-format'
NeoBundle 'dyng/ctrlsf.vim'
" }}}
" deoplete {{{
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'Shougo/neco-vim'
" NeoBundle 'Shougo/neoinclude.vim'
NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'wellle/tmux-complete.vim'
" NeoBundle 'deoplete-plugins/deoplete-go'
NeoBundle 'deoplete-plugins/deoplete-zsh'
" NeoBundle 'deoplete-plugins/deoplete-jedi'
" NeoBundle 'deoplete-plugins/deoplete-asm'
" NeoBundle 'deoplete-plugins/deoplete-docker'
" NeoBundle 'carlitux/deoplete-ternjs', { 'build': {'unix': 'npm install && npm install -g tern'}}
" NeoBundle 'fishbullet/deoplete-ruby'
" NeoBundle 'kiddos/deoplete-cpp', { 'build': {'unix': './install.sh'}}
" NeoBundle 'mhartington/nvim-typescript'
" NeoBundle 'padawan-php/deoplete-padawan', { 'build': {'unix': 'composer install' }}
" NeoBundle 'autozimu/LanguageClient-neovim'
NeoBundle 'prabirshrestha/vim-lsp'
NeoBundle 'mattn/vim-lsp-settings'
NeoBundle 'lighttiger2505/deoplete-vim-lsp'
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
" " }}}
" python {{{
NeoBundle 'tell-k/vim-autopep8'
NeoBundle 'Vimjas/vim-python-pep8-indent'
" }}}
" javascript   {{{
NeoBundle 'elzr/vim-json'
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'peitalin/vim-jsx-typescript'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'chemzqm/vim-jsx-improve'
NeoBundle 'MaxMEllon/vim-jsx-pretty'
NeoBundle 'peitalin/vim-jsx-typescript'
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
" vhdl {{{
NeoBundle 'kiddos/vim-vhdl'
" }}}
" ruby {{{
NeoBundle 'vim-ruby/vim-ruby'
" }}}
" php {{{
NeoBundle 'stanangeloff/php.vim'
NeoBundle 'shawncplus/phpcomplete.vim'
" }}}
" html {{{
NeoBundle 'othree/html5.vim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tpope/vim-markdown'
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
" Julia {{{
NeoBundle 'JuliaEditorSupport/julia-vim'
" }}}
" Rust {{{
NeoBundle 'rust-lang/rust.vim'
" }}}
" Dart {{{
NeoBundle 'dart-lang/dart-vim-plugin'
" }}}
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

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
" }}}
" code display settings {{{
set modeline
set textwidth=120
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
autocmd FileType csharp normal zR
autocmd FileType python,javascript normal zR
autocmd FileType html normal zR
" }}}
" }}}
" indenting setting {{{
" default {{{
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set expandtab
set smartindent
set cindent
set copyindent
set preserveindent
" }}}
" c/c++ indenting {{{
" autocmd Filetype c,cpp,objc,objcpp,cuda,arduino setlocal cinoptions=>s,^0,:2,W4,m1,g1,)10,(0
autocmd Filetype c,cpp,objc,objcpp,cuda,arduino setlocal cinoptions=(0,>1s,:2,g1,m1,+4
" }}}
" rust indenting {{{
autocmd FileType rust setlocal tabstop=4
autocmd FileType rust setlocal softtabstop=2
autocmd FileType rust setlocal shiftwidth=2
" }}}
" c# {{{
autocmd FileType cs setlocal tabstop=4
autocmd FileType cs setlocal softtabstop=4
autocmd FileType cs setlocal shiftwidth=4
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
" set altkeymap
set backspace=indent,eol,start
set clipboard=unnamed,unnamedplus
set linebreak
set shiftround
set complete=.,w,b,u,U,t,k
set completeopt=menu,menuone
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
set pumheight=20
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
autocmd FileType csharp nnoremap ; $a;
autocmd FileType java,javascript,css,html,matlab,php,perl,typescript nnoremap ; $a;
" }}}
" }}}
" color scheme settings {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
set termguicolors
set cursorline
syntax enable
syntax on
let g:material_theme_style = 'darker'
colorscheme malokai
" colorscheme material
" colorscheme molokai
" }}}
" plugin settings {{{
" jsx-pretty settings {{{
let g:vim_jsx_pretty_enable_jsx_highlight = 0
highlight def link jsxTag Function
highlight def link jsxTagName Function
highlight def link jsxString String
highlight def link jsxNameSpace Function
highlight def link jsxComment Error
highlight def link jsxAttrib Type
highlight def link jsxCloseTag Identifier
highlight def link jsxCloseString Identifier
" }}}
" delimitMate settings {{{
autocmd FileType html setlocal matchpairs+=<:>
autocmd FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1
let delimitMate_balance_matchpairs = 1
imap <expr> <CR> pumvisible() ? "\<C-N><C-Y>": "<Plug>delimitMateCR"
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
" deoplete settings {{{
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\  'auto_complete_delay': 30,
\  'auto_refresh_delay': 100,
\  'camel_case': v:true,
\  'check_stderr': v:false,
\  'ignore_case': v:true,
\  'ignore_sources': {
\     '_': ['around'],
\     'cpp': ['around', 'tmux-complete'],
\  },
\  'refresh_always': v:true,
\  'skip_chars': [],
\  'max_list': 600,
\  'smart_case': v:true,
\  'min_pattern_length': 1,
\})
call deoplete#custom#option('keyword_patterns', {
\ '_': '[a-zA-Z_^{};]*',
\})
call deoplete#custom#source('buffer', 'min_pattern_length', 3)

inoremap <expr> <C-Space> deoplete#manual_complete()
" LSP {{{
let g:lsp_settings_filetype_html = ['html-languageserver', 'angular-language-server']
let g:lsp_settings_filetype_javascript = 'javascript-typescript-stdio'
let g:lsp_diagnostics_enabled = 0
autocmd FileType javascript,html let b:lsp_diagnostics_enabled = 1
" }}}
" deoplete-cpp {{{
let g:deoplete#sources#cpp#include_paths = [
\ '/usr/include/eigen3',
\ '/usr/include/pcl-1.8',
\]
" }}}
" ternjs {{{
" let g:deoplete#sources#ternjs#timeout = 3
" let g:deoplete#sources#ternjs#types = 1
" let g:deoplete#sources#ternjs#depths = 1
" let g:deoplete#sources#ternjs#include_keywords = 1
" let g:deoplete#sources#ternjs#in_literal = 0
" let g:deoplete#sources#ternjs#filetypes = ['jsx', 'javascript.jsx', 'vue']
" call deoplete#custom#source('tern', 'input_pattern', '\w+|[^.]\.\s*?\w*')
" autocmd FileType javascript,typescript,html call deoplete#custom#option('auto_complete_delay', 200)
" }}}
" neosnippet settings {{{
let g:neosnippet#enable_snipmate_compatibility = 1
" let g:neosnippet#snippets_directory = '~/.config/nvim/bundle/snippets.vim/snippets'

imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
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
" tmuxline {{{
function StartAPMServer()
  silent exec ':!python3 ~/.config/nvim/apm_server.py --debug=False &'
endfunction
call StartAPMServer()

let g:tmuxline_preset = {
\   'a'       : '#S',
\   'b'       : '#W',
\   'c'       : '',
\   'win'     : '#I #W',
\   'cwin'    : '#I #W',
\   'y'       : 'APM: #(python3 ~/.config/nvim/apm_client.py) #(uptime  | cut -d " " -f 1,2)',
\   'z'       : '#(whoami)@#H',
\   'options' : {'status-justify' : 'left'}
\   }
let g:tmuxline_separators = {
\   'left' : '➤',
\   'left_alt': '➡',
\   'right' : '⏎ ',
\   'right_alt' : '⇦ ',
\   'space' : ' '
\   }
" }}}
" ctrlp setting {{{
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/](.git|.hg|.svn|node_modules)$',
\ 'file': '\v\.(exe|so|dll|o|class)$',
\ }
let g:ctrlp_max_files = 0
let g:ctrlp_open_new_file = 't'
let g:ctrlp_open_multiple_files = 't'

" }}}
" emmet {{{
let g:user_emmet_togglecomment_key = '<C-y>#'
" }}}
" useful functions and keybindings {{{
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
nmap <silent><F1> :NERDTreeToggle .<CR>
imap <F1> <Esc>:NERDTreeToggle .<CR>
nmap <silent><F2> :GitGutterToggle<CR>
imap <F2> <Esc>:GitGutterToggle<CR>
" a.vim shortcut
nmap <leader><leader>a :A<CR>
" }}}
" }}}
