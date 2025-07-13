return {
  'kiddos/molokai-zenith.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    local colorscheme = require('molokai-zenith')
    colorscheme.setup()
    colorscheme.colorscheme()
  end
}
