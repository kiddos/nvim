""
""	Author: Joseph Yu
""	Last Modified: 2020/12/03
""

set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.config/nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
" color scheme {{{
NeoBundle 'kiddos/malokai.vim'
NeoBundle 'kaicataldo/material.vim'
NeoBundle 'tomasr/molokai'
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
" new features {{{
NeoBundle 'neovim/nvim-lspconfig'
NeoBundle 'nvim-lua/completion-nvim'
NeoBundle 'steelsojka/completion-buffers'
NeoBundle 'albertoCaroM/completion-tmux'
NeoBundle 'nvim-telescope/telescope.nvim', {'depends': ['nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim']}
NeoBundle 'kyazdani42/nvim-tree.lua', {'depends': 'kyazdani42/nvim-web-devicons'}
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
NeoBundle 'kannokanno/previm'
NeoBundle 'arecarn/crunch.vim', { 'depends': 'arecarn/selection.vim' }
NeoBundle 'kiddos/snippets.vim'
NeoBundle 'rhysd/vim-clang-format'
NeoBundle 'dyng/ctrlsf.vim'
NeoBundle 'Shougo/neosnippet.vim'
" }}}
" libs {{{
" NeoBundle 'MarcWeber/vim-addon-mw-utils'
" NeoBundle 'tomtom/tlib_vim'
" }}}
" C family {{{
NeoBundle 'octol/vim-cpp-enhanced-highlight'
NeoBundle 'kiddos/a.vim'
NeoBundle 'beyondmarc/opengl.vim'
NeoBundle 'tikhomirov/vim-glsl'
NeoBundle 'beyondmarc/hlsl.vim'
NeoBundle 'kiddos/vim-protobuf'
" " }}}
" python {{{
NeoBundle 'tell-k/vim-autopep8'
NeoBundle 'Vimjas/vim-python-pep8-indent'
" }}}
" javascript   {{{
NeoBundle 'elzr/vim-json'
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'pangloss/vim-javascript'
" NeoBundle 'mxw/vim-jsx'
" NeoBundle 'chemzqm/vim-jsx-improve'
NeoBundle 'MaxMEllon/vim-jsx-pretty'
NeoBundle 'peitalin/vim-jsx-typescript'
" }}}
" go {{{
NeoBundle 'fatih/vim-go'
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
" }}}
" html {{{
NeoBundle 'othree/html5.vim'
NeoBundle 'tpope/vim-markdown'
" }}}
" css {{{
NeoBundle 'ap/vim-css-color'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'groenewege/vim-less'
NeoBundle '1995eaton/vim-better-css-completion'
NeoBundle 'othree/csscomplete.vim'
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
NeoBundleCheck

" lsp settings {{{
" setup {{{
lua << EOF
local lspconfig = require('lspconfig');
lspconfig.clangd.setup({
  cmd={"clangd-10", "--background-index"},
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false,
        virtual_text = false,
        signs = false,
        update_in_insert = false
      }
    )
  }
});
lspconfig.tsserver.setup({
  filetypes = {"typescript", "typescriptreact", "typescript.tsx"},
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git")
})
-- lspconfig.pyls.setup{}
lspconfig.jedi_language_server.setup{}
lspconfig.jdtls.setup({
  root_dir = lspconfig.util.root_pattern(".git", "pom.xml", "build.gradle")
})
lspconfig.vimls.setup{}
lspconfig.bashls.setup{}
lspconfig.cmake.setup{}
lspconfig.angularls.setup{}
lspconfig.flow.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.sumneko_lua.setup{}

local util = require('lspconfig/util')
local dart_sdk_bin = util.base_install_dir .. "/dart-sdk/bin/"
local dart_bin = dart_sdk_bin .. "dart"
local analysis_server = dart_sdk_bin .. "snapshots/analysis_server.dart.snapshot"
lspconfig.dartls.setup{
  cmd = {dart_bin, analysis_server, "--lsp"}
}
-- lspconfig.webmacrols.setup{}
EOF
" }}}
" sign {{{
sign define LspDiagnosticsSignError text=🛑 texthl=Text linehl= numhl=
sign define LspDiagnosticsSignWarning text=❗️ texthl=Text linehl= numhl=
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
" completion settings {{{
autocmd BufEnter * lua require('completion').on_attach()
autocmd FileType cpp let g:completion_trigger_character = ['.', '::', '->']
imap <expr> <C-Space> "\<Plug>(completion_trigger)"
imap <expr> <CR> pumvisible() ? "\<C-N><C-U>" : "\<Plug>delimitMateCR"
let g:completion_timer_cycle = 600
let g:completion_trigger_keyword_length = 2
let g:completion_confirm_key = "\<C-U>"
let g:completion_matching_ignore_case = 1
let g:completion_trigger_on_delete = 1
let g:completion_enable_snippet = 'Neosnippet'
let g:completion_enable_server_trigger = 0
let g:completion_chain_complete_list = [
\  {'complete_items': ['lsp', 'snippet', 'buffer', 'tmux', 'path']},
\  {'mode': '<c-p>'},
\  {'mode': '<c-n>'}
\]
let g:completion_word_ignored_ft = ['json', 'text']
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
autocmd FileType csharp normal zR
autocmd FileType python,javascript normal zR
autocmd FileType html normal zR
autocmd FileType typescript normal zR
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
set linebreak
set shiftround
set complete=.,w,b,u,U,t,k
set completeopt=menu,menuone,noselect
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
set termguicolors
set background="dark"
syntax enable
syntax on
let g:material_theme_style = 'darker'
colorscheme malokai
" colorscheme material
" colorscheme molokai
" }}}
" plugin settings {{{
" telescope {{{
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
" }}}
" ale settings {{{
let g:ale_linters = {
\  'python': ['flake8'],
\  'javascript': ['eslint']
\}
let g:ale_python_flake8_options = '--ignore=E111,E121,E123,E126,E226,E24,E704,W503,W504'
let g:ale_linters_ignore = {
\  'javascript': ['flow']
\}
" }}}
" jsx-pretty settings {{{
let g:vim_jsx_pretty_enable_jsx_highlight = 0
highlight def link jsxTag Keyword
highlight def link jsxTagName Keyword
highlight def link jsxAttrib Type
highlight def link jsxString String
highlight def link jsxNameSpace Identifier
highlight def link jsxComment Comment
highlight def link jsxCloseTag Text
highlight def link jsxCloseString Text
" }}}
" delimitMate settings {{{
autocmd FileType html setlocal matchpairs+=<:>
autocmd FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1
let delimitMate_balance_matchpairs = 1
let delimitMate_insert_eol_marker = 2
let delimitMate_smart_matchpairs = ''
let delimitMate_smart_quotes = '\w\%#'
" imap <expr> <CR> pumvisible() ? "\<C-N>": "<Plug>delimitMateCR"
" }}}
" airline settings {{{
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
let g:airline_symbols.branch = '🛠 '
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
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#overflow_marker = '…'
let airline#extensions#tabline#current_first = 1
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#exclude_preview = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#show_tab_type = 0
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
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
\  'a'       : '#S',
\  'b'       : '#W',
\  'c'       : '',
\  'win'     : '#I #W',
\  'cwin'    : '#I #W',
\  'y'       : 'APM: #(python3 ~/.config/nvim/apm_client.py) #(uptime  | cut -d " " -f 1,2)',
\  'z'       : '#(whoami)@#H',
\  'options' : {'status-justify' : 'left'}
\}
let g:tmuxline_separators = {
\  'left': '◗',
\  'left_alt': '◗',
\  'right' : '◖',
\  'right_alt' : '◖',
\  'space' : ' '
\}
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
" LuaTree settings {{{
let g:lua_tree_tab_open = 1
nmap <silent><F3> :LuaTreeToggle<CR>
imap <F3> <Esc>:LuaTreeToggle<CR>
" }}}
" }}}
