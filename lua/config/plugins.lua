---------------------
-- package management
---------------------

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- file management
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
    end
  },
  --lsp config
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require('ide.lspconf')
    end,
  },
  -- lsp extension
  {
    'dcampos/nvim-snippy',
    config = function()
      require('snippy').setup({
        mappings = {
          is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
          },
          nx = {
            ['<leader>x'] = 'cut_text',
          },
        },
      })
    end,
  },
  'dcampos/cmp-snippy',
  'folke/trouble.nvim',
  'folke/neodev.nvim',
  -- linting
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        go = { 'golangcilint' }
      }
    end
  },
  -- debugging
  {
    'mfussenegger/nvim-dap',
    config = function()
      require('ide.debug')
    end
  },
  'rcarriga/nvim-dap-ui',
  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('ide.syntax')
    end,
  },
  'nvim-treesitter/playground',
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup {
        exclude = {
          filetypes = {
            "css",
            "lua",
            "nim",
            "racket",
            "startify"
          }
        },
        scope = {
          enabled = false,
          show_start = false,
          show_end = false
        },
      }
    end
  },
  -- colorchemes
  'Mofiqul/dracula.nvim',
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'gruvbox',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = ' ', right = ' ' },
        },
      })
    end
  },
  -- Telescope
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-dap.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      local telescope_theme = 'dropdown'
      require('telescope').setup({
        -- set theme of used pickers
        pickers = {
          git_files = {
            theme = telescope_theme,
          },
          find_files = {
            theme = telescope_theme,
          },
          buffers = {
            theme = telescope_theme,
          },
          help_tags = {
            theme = telescope_theme,
          },
          keymaps = {
            theme = telescope_theme,
          }
        }
      })
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('dap')
    end,
  },
  -- telekasten
  {
    'renerocksai/telekasten.nvim',
    config = function()
      require('telekasten').setup({
        home = vim.fn.expand("~/zkast"),
      })
    end
  },
  -- lang support
  {
    'jpalardy/vim-slime',
    config = function()
      vim.g.slime_target = "neovim"
    end,
  },
  'simrat39/rust-tools.nvim', -- rust
  {                           -- scala
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    ft = { "scala", "sbt", "java" },
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  'mattn/emmet-vim',         -- html
  'alaviss/nim.nvim',        -- nim
  'preservim/nerdcommenter', -- comments
  -- ({['''']}) management,
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
  },
  -- tables
  'dhruvasagar/vim-table-mode',
  -- git,
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('gitsigns').setup()
    end,
  },
  -- vim start screen,
  'mhinz/vim-startify',
  -- which key,
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
  -- local dev
  {
    dir = "~/Git/gotest.nvim",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      -- defaults
      vim.g.gotest = {
        test_cmd = "go test -run ",
        preview_cutoff = 0,
        preview_width = 0.67
      }
      local goTest = require("gotest")
      vim.keymap.set("n", "<Space>tf", goTest.goFuncTester)
      vim.keymap.set("n", "<Space>tm", goTest.goModTester)
    end
  }
})
