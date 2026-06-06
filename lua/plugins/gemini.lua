return {
  'kiddos/gemini.nvim',
  dependencies = {
    'kiddos/pawtocomplete.nvim',
  },
  event = 'InsertEnter',
  cmd = { 'GeminiTask', 'GeminiChat', 'GeminiAuthenticate' },
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
    },
    oauth = {
      client_id = vim.fn.getenv('GEMINI_OAUTH_CLIENT_ID'),
      client_secret = vim.fn.getenv('GEMINI_OAUTH_CLIENT_SECRET'),
    }
  }
}
