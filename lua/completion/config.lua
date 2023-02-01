local config = {
  completion = {
    abbr_max_len = 60,
    menu_max_len = 20,
    throttle_time = 66,
    debounce_time = 200,
    delay = 60,
    buffer_max_lines = 20000,
    buffer_reindex_line_range = 500,
    buffer_lru_size = 6000,
    special_chars = {'{', ':', ';', '(', '[', ','},
    cr_mapping = nil,
  },
  info = {
    max_width = 120,
    max_height = 30,
    delay = 200,
  },
  signature = {
    max_width = 120,
    max_height = 30,
    delay = 200,
  }
}

return config
