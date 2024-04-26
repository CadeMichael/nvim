return {
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  {
    'mattn/emmet-vim',
    config = function()
      vim.g.user_emmet_install_global = 0
    end
  },
  {
    'preservim/nerdcommenter',
    config = function()
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDCustomDelimiters = { python = { left = "#", right = "" } }
      vim.keymap.set({ 'v', 'n' }, '<Space>;', '<Plug>NERDCommenterToggle', { noremap = true, silent = true })
    end
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
  },
  'dhruvasagar/vim-table-mode',
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup({
        window = {
          border = 'double'
        }
      })
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set('n', '<Space>n', '<cmd>NvimTreeToggle<CR>', { desc = "open tree" })
    end
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<M-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<M-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<M-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<M-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },
}
