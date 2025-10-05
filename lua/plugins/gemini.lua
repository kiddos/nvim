return {
  'kiddos/gemini.nvim',
  dependencies = {
    'kiddos/pawtocomplete.nvim',
  },
  event = 'InsertEnter',
  cmd = { 'GeminiTask', 'GeminiChat' },
  opts = {
    completion = {
      can_complete = function()
        return not require('pawtocomplete.completion_menu').is_opened()
      end
    },
    chat_config = {
      window = {
        position = "right",     -- left, right, new_tab, tab
        width = 80,               -- number of columns of the left/right window
      }
    }
  }
}
