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
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
    end
  },
  --lsp config
  {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      require('ide.lspconf')
    end
  },
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
    end
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
          theme = used.Dracula and 'dracula' or 'gruvbox',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = ' ', right = ' ' },
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
    end,
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
      require('nvim-autopairs').setup({
        map_cr = false,
      })
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
}

if used.Dracula then
  table.insert(plugins, {
    'Mofiqul/dracula.nvim'
  })
end

if used.Sn then
  table.insert(plugins, {
    "michaelb/sniprun",
    branch = "master",
    build = "sh install.sh",
    config = function()
      require("sniprun").setup({
        display = { "Classic" },
        interpreter_options = {
          GFM_original = {
            use_on_filetypes = { "telekasten" }
          }
        },
        selected_interpreters = { "Python3_fifo" },
        repl_enable = { "Python3_fifo" },
      })
    end,
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
