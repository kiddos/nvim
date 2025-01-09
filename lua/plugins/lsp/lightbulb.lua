return {
  'kosayoda/nvim-lightbulb',
  event = 'VeryLazy',
  config = function()
    require("nvim-lightbulb").setup({
      autocmd = { enabled = true }
    })
  end
}
