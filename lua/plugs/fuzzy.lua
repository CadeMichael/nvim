return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require('telescope').setup({})
          require('telescope').load_extension('fzf')
        end,
      },
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<space>f', builtin.find_files, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<space>/', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<space>g/', builtin.git_status, { desc = 'Telescope git status' })
      vim.keymap.set('n', '<space>gb', builtin.git_branches, { desc = 'Telescope git branches' })
      vim.keymap.set('n', '<space>,', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<space>h', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<space>m', builtin.keymaps, { desc = 'Telescope keymaps' })
      vim.keymap.set('n', '<space>E', builtin.diagnostics, { desc = 'Telescope diagnostics' })
      vim.keymap.set('n', 'grr', builtin.lsp_references, { desc = 'Telescope LSP references' })
    end
  },
}
