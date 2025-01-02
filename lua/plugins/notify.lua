return {
  'rcarriga/nvim-notify',
  lazy = false,
  config = function()
    local notify = require('notify')
    notify.setup({
      max_width = 60,
      timeout = 2000,
    })
    vim.notify = function(msg, level, opts)
      notify(msg, level, opts)
      print(msg)
    end
  end,
}
