local config = {
  completion = {
    abbr_max_len = 60,
    menu_max_len = 20,
    throttle_time = 66,
    debounce_time = 200,
    delay = 60,
    buffer_max_size = 1000,
    buffer_reindex_range = 100,
    lru_size = 1000,
    special_chars = {'{', ':', ';', '(', '[', ','},
    cr_mapping = nil,
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
