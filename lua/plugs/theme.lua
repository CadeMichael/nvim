return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/playground' },
    config = function()
      require 'nvim-treesitter.configs'.setup({
        -- Modules and its options go here
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "lean" },
        },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
        indent = { enable = false },
        -- playground
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,
          persist_queries = false,
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        },
      })

      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      parser_config.lean = {
        install_info = {
          url = "~/Downloads/tsgrammars/tree-sitter-lean", -- local path or git repo
          files = { "src/parser.c", "src/scanner.c" },     -- note that some parsers also require src/scanner.c or src/scanner.cc
          generate_requires_npm = false,                   -- if stand-alone parser without npm dependencies
          requires_generate_from_grammar = false,          -- if folder contains pre-generated src/parser.c
        },
      }
      parser_config.koka = {
        install_info = {
          url = "https://github.com/mtoohey31/tree-sitter-koka",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
        },
        filetype = "koka",
      }
      -- multi use treesitters
      vim.treesitter.language.register("markdown", "telekasten")

      -- folding
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.o.foldlevel = 32
      vim.cmd [[set nofoldenable]]
    end
  },
  {
    "rebelot/kanagawa.nvim",
    -- priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      require("kanagawa").setup({
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          }
        }
      })
      vim.cmd.colorscheme 'kanagawa'
      -- transparent BG
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
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
    'MeanderingProgrammer/markdown.nvim',
    main = "render-markdown",
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('render-markdown').setup({
        heading = {
          -- enabled = false,
          sign = false,
          icons = {},
        },
        code = {
          sign = false,
        }
      })
    end
  }
}
