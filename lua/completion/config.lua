local config = {
  completion = {
    abbr_max_len = 60,
    menu_max_len = 20,
    delay = 100,
    exclude_trigger = {
      c = { '{' },
      cpp = { '{' },
      lua = { '{', ')' },
      javascript = { '{' },
      typescript = { '{' },
    },
  },
  info = {
    max_width = 60,
    max_height = 20,
    delay = 200,
  },
  signature = {
    max_width = 60,
    max_height = 20,
    delay = 200,
  }
}

return config
