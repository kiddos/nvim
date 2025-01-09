return {
  'iamcco/markdown-preview.nvim',
  build = 'cd app && ./install.sh',
  ft = { 'markdown' },
  cmd = 'MarkdownPreview',
}
