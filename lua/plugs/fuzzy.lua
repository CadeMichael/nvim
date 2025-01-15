return {
  'nvim-telescope/telescope.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').setup({})
      require('telescope').load_extension('fzf')
      local tsb = require 'telescope.builtin'
      vim.keymap.set('n', '<Space>pf', tsb.git_files, { desc = 'ts git files' })
      vim.keymap.set('n', '<Space>h', tsb.help_tags, { desc = 'ts help' })
      vim.keymap.set('n', '<Space>m', tsb.keymaps, { desc = 'ts maps' })
      vim.keymap.set('n', '<Space>gs', tsb.git_status, { desc = 'git diff' })
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  -- telekasten
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
