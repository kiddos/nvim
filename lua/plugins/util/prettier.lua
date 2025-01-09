return {
  'prettier/vim-prettier',
  build = 'yarn install --frozen-lock-file --production',
  tag = '1.0.0',
  ft = { 'javascript', 'typescript' },
  cmd = 'Prettier',
}
