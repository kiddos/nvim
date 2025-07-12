return {
  'onsails/lspkind-nvim',
  event = { 'InsertEnter' },
  config = function()
    require('lspkind').init()
  end
}
