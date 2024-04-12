---------------------
-- package management
---------------------

local used = require('included')
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

local plugins = {
  -- file management
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
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
        go = { 'golangcilint' },
      }
    end
  },
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
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('lualine').setup({
        options = {
          theme = used.Cat and 'catppuccin' or 'gruvbox',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = ' ', right = ' ' },
        },
        sections = {
          lualine_x = { 'encoding', 'filetype' },
        },
      })
    end
  },
  -- Telescope
  'nvim-telescope/telescope.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      local default_theme = require('telescope.themes').get_ivy({})

      require('telescope').setup({
        defaults = {
          layout_strategy = default_theme.layout_strategy,
          layout_config = default_theme.layout_config,
        },
      })
      require('telescope').load_extension('fzf')
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
    end
  },
  -- lang support
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  'mattn/emmet-vim',         -- html
  'preservim/nerdcommenter', -- comments
  -- ({['''']}) management,
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
  },
  {
    "Vigemous/iron.nvim",
    config = function()
      require("ide.repl")
    end,
  },
  -- tables
  'dhruvasagar/vim-table-mode',
  -- git,
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require('neogit').setup {}
    end
  },
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
}

if used.Cat then
  table.insert(plugins, {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
  })
end

if used.Scala then
  table.insert(plugins, { -- scala
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    ft = { "scala", "sbt", "java" },
  })
end

require('lazy').setup(plugins)
