local config = {
  completion = {
    abbr_max_len = 60,
    menu_max_len = 20,
    delay = 100,
    exclude_trigger = {
      __global__ = {'{', ')'},
    },
    buffer_max_size = 1000,
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
