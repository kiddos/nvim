return {
  'kiddos/google-translate.nvim',
  build = { 'pip install -r requirements.txt', ':UpdateRemotePlugins' },
  cmd = { 'TranslateCN', 'TranslateTW', 'TranslateEN' },
  opts = {},
}
