return {
  'dcampos/nvim-snippy',
  event = 'InsertEnter',
  opts = {
    mappings = {
      is = {
        ['<Tab>'] = 'expand_or_advance',
        -- ['<S-Tab>'] = 'previous',
      },
    },
  },
}
