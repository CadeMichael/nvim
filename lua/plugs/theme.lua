return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {},
        modules = {},
        sync_install = false,
        auto_install = false,
        ignore_install = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        }
      }

      -- folding
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.o.foldlevel = 32
      vim.cmd [[set nofoldenable]]

      vim.treesitter.language.register("markdown", "telekasten")

      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

      parser_config.koka = {
        install_info = {
          url = "https://github.com/mtoohey31/tree-sitter-koka",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
        },
        filetype = "koka",
      }
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      -- vim.o.background = "light"
      vim.cmd.colorscheme 'rose-pine'
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = ' ', right = ' ' },
        },
        sections = {
          lualine_x = { 'encoding', 'filetype' },
        },
      })
    end
  },
  {
    "sotte/presenting.nvim",
    cmd = { "Presenting" },
    config = function()
      require("presenting").setup({
        options = {
          width = 84,
        }
      })
    end,
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    main = "render-markdown",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local renderM = require('render-markdown')
      renderM.setup({
        enabled = false,
        render_modes = true,
        heading = {
          sign = false,
          icons = {},
        },
        code = {
          sign = false,
        }
      })
      Map('n', '<space>M', renderM.toggle, Opts, "toggle render markdown")
    end
  }
}
