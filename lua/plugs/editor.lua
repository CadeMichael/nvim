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
      vim.g.NERDCustomDelimiters = { python = { left = '#', right = '' } }
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
        win = {
          border = 'double'
        }
      })
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local oil = require('oil')
      require('oil').setup()
      vim.keymap.set('n', '<Space>n', oil.toggle_float, { desc = 'open tree' })
    end
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<M-h>', '<cmd>TmuxNavigateLeft<cr>' },
      { '<M-j>', '<cmd>TmuxNavigateDown<cr>' },
      { '<M-k>', '<cmd>TmuxNavigateUp<cr>' },
      { '<M-l>', '<cmd>TmuxNavigateRight<cr>' },
    },
  },
  -- Testing
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'rouge8/neotest-rust'
    },
    config = function()
      local opts = { buffer = bufnr, noremap = true, silent = true }
      local neotest = require('neotest')
      neotest.setup {
        adapters = {
          require("neotest-rust") {
            args = { "--no-capture" },
          }
        }
      }
      vim.keymap.set('n', '<space>T', function ()
        neotest.run.run(vim.fn.expand('%'))
      end, opts)
      vim.keymap.set('n', '<space>tt', neotest.run.run, opts)
      vim.keymap.set('n', '<space>ts', neotest.summary.open, opts)
      vim.keymap.set('n', '<space>to', neotest.output.open, opts)
    end
  }
}
