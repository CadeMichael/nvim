return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      local fzf = require('fzf-lua')
      local notes_dir = '~/zkast'
      local function find_notes()
        fzf.files({cwd=notes_dir})
      end
      vim.keymap.set('n', '<space>f', fzf.files, { desc = 'find files' })
      vim.keymap.set('n', '<space>/', fzf.live_grep, { desc = 'live grep' })
      vim.keymap.set('n', '<space>gf', fzf.git_files, { desc = 'git files' })
      vim.keymap.set('n', '<space>gb', fzf.git_branches, { desc = 'git branches' })
      vim.keymap.set('n', '<space>,', fzf.buffers, { desc = 'find buffers' })
      vim.keymap.set('n', '<space>h', fzf.helptags, { desc = 'helptags' })
      vim.keymap.set('n', '<space>n', find_notes, { desc = 'find notes' })
      vim.keymap.set('n', '<space>m', fzf.keymaps, { desc = 'keymaps' })
      vim.keymap.set('n', '<space>E', fzf.diagnostics_document, { desc = 'diagnostics document' })
      vim.keymap.set('n', 'grr', fzf.lsp_references, { desc = 'lsp references' })
    end
  },
}
