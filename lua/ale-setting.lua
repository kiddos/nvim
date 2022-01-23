vim.g.ale_disable_lsp = 1

vim.g.ale_cpp_cc_options = '-std=c++17 -Wall'
vim.g.ale_linters = {
  python = {},
  javascript = {},
  javascriptreact = {}
}
vim.g.ale_python_flake8_options = '--ignore=E111,E121,E123,E126,E226,E24,E704,W503,W504'
vim.g.ale_linters_ignore = {
  java = {'javac', 'checkstyle', 'eclipselsp', 'pmd'},
  javascript = {'flow'},
  json = {'eslint'},
  dart = {'analysis_server', 'analyze', 'format', 'dartfmt'},
}
