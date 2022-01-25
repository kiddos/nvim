-- barbar
require('barbar-setting').setup()

-- git
vim.api.nvim_set_var('gitgutter_enabled', false)
vim.api.nvim_set_keymap('n', '<F2>', ':GitGutterToggle<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('i', '<F2>', '<Esc>:GitGutterToggle<CR>', {noremap=true, silent=true})

vim.api.nvim_set_var('gitblame_enabled', false)
vim.api.nvim_set_keymap('n', '<F3>', ':GitBlameToggle<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('i', '<F3>', '<Esc>:GitBlameToggle<CR>', {noremap=true, silent=true})

-- NerdTree
vim.api.nvim_set_var('NERDSpaceDelims', true)
vim.api.nvim_set_var('NERDCompactSexyComs', true)
vim.api.nvim_set_var('NERDDefaultAlign', 'left')
vim.api.nvim_set_var('NERDCustomDelimiters ', {
  c = {left='//'},
  arduino = {left='//'},
  vim = {left='"'},
  conf = {left='#'},
  prototxt = {left='#'}
})

vim.api.nvim_set_keymap('n', '<F1>', ':NERDTreeToggle .<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('i', '<F1>', '<Esc>:NERDTreeToggle .<CR>', {noremap=true, silent=true})

-- A
vim.api.nvim_set_keymap('n', '<Leader><Leader>a', ':A<CR>', {silent=true})

-- emmet
vim.api.nvim_set_var('user_emmet_togglecomment_key', '<C-y>#')

-- ale
vim.api.nvim_set_var('ale_disable_lsp', true)
vim.api.nvim_set_var('ale_cpp_cc_options', '-std=c++17 -Wall')
vim.api.nvim_set_var('ale_linters', {
  python = {},
  javascript = {},
  javascriptreact = {},
})
vim.api.nvim_set_var('ale_python_flake8_options',  '--ignore=E111,E121,E123,E126,E226,E24,E704,W503,W504')
vim.api.nvim_set_var('ale_linters_ignore', {
  java = {'javac', 'checkstyle', 'eclipselsp', 'pmd'},
  javascript = {'flow'},
  json = {'eslint'},
  dart = {'analysis_server', 'analyze', 'format', 'dartfmt'},
})


-- todo-comments
require('todo-comments').setup {
  highlight = {
    max_line_len = 10000,
    exclude = {'', 'conf', 'json', 'xml', 'markdown'},
  },
}
vim.api.nvim_set_keymap('n', '<F5>', ':TodoLocList<CR>', {noremap=true, silent=true})


-- flutter
require('flutter-tools').setup{}
