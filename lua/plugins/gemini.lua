return {
  'kiddos/gemini.nvim',
  dependencies = {
    'kiddos/pawtocomplete.nvim',
  },
  event = 'InsertEnter',
  cmd = { 'GeminiTask', 'GeminiChat' },
  opts = {
    completion = {
      trigger_key = '<C-Space>',
      can_complete = function()
        return not require('pawtocomplete.completion_menu').is_opened()
      end
    },
    chat_config = {
      window = {
        position = "right",
        width = 80,
      }
    }
  }
}
