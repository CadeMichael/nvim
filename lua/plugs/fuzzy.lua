return {
  'nvim-telescope/telescope.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').setup({})
      require('telescope').load_extension('fzf')
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'renerocksai/telekasten.nvim',
    dependencies = { 'renerocksai/calendar-vim' },
    config = function()
      require('telekasten').setup({
        home = vim.fn.expand("~/zkast"),
      })
      vim.keymap.set('n', '<Space><Space>', '<cmd>Telekasten panel<CR>', { desc = 'telekasten panel' })
      vim.keymap.set('n', '<Space>rf', '<cmd>Telekasten find_notes<CR>', { desc = 'telekasten find notes' })
    end
  },
}
