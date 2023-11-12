local config = {
  completion = {
    abbr_max_len = 60,
    menu_max_len = 20,
    buffer_max_lines = 20000,
    buffer_reindex_line_range = 500,
    buffer_lru_size = 6000,
    special_chars = { '{', ':', ';', '(', '[', ',', ')', ']', '+', '-', '*', '/', '%', '!', '&', '|' },
    -- special_chars = {},
    cr_mapping = nil,
    delay = 200,
  },
  info = {
    max_width = 120,
    max_height = 30,
    delay = 500,
  },
  signature = {
    max_width = 120,
    max_height = 30,
    delay = 500,
  }
}

return config
