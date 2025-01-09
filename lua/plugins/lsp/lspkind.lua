return {
  'onsails/lspkind-nvim',
  event = 'VeryLazy',
  config = function()
    require('lspkind').init()
  end
}
