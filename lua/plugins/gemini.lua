return {
  'kiddos/gemini.nvim',
  dependencies = {
    'kiddos/pawtocomplete.nvim',
  },
  event = 'InsertEnter',
  opts = {
    completion = {
      can_complete = function()
        return not require('pawtocomplete.completion_menu').is_opened()
      end
    }
  }
}
