return {
  'rcarriga/nvim-notify',
  tag = 'v3.15.0',
  lazy = false,
  config = function()
    local notify = require('notify')
    notify.setup({
      max_width = 60,
      timeout = 2000,
    })
    vim.notify = function(msg, level, opts)
      notify(msg, level, opts)
      print(vim.inspect(msg))
    end
  end,
}
