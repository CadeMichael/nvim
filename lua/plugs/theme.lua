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

      -- telekasten
      vim.treesitter.language.register("markdown", "telekasten")

      -- folding
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.o.foldlevel = 32
      vim.cmd [[set nofoldenable]]

      -- Adding Parsers
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

      -- Lean4
      if vim.fn.has("macunix") == 0 then
        parser_config.lean = {
          install_info = {
            url = "~/Downloads/tree-sitter-lean",
            files = { "src/parser.c", "src/scanner.c" },
          },
          filetype = "lean",
        }
      end
    end
  },
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
      vim.keymap.set('n', '<Space>I', '<cmd>IBLToggle<CR>', { desc = "toggle indent highlighting" })
      vim.keymap.set('n', '<Space>S', '<cmd>IBLToggleScope<CR>', { desc = "toggle indent scope highlighting" })
    end
  },
  -- colorchemes
  {
    'mhinz/vim-startify',
    config = function()
      -- start screen
      vim.g.startify_custom_header = {
        [[                                                      ]],
        [[   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
        [[   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
        [[   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
        [[   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        [[                                                      ]],
      }
    end
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    priority = 1000,
    config = function()
      vim.opt.background = 'dark'
      vim.opt.termguicolors = true

      vim.cmd.colorscheme 'oxocarbon'

      if vim.g.neovide then
        vim.g.neovide_scale_factor = 0.75
      else
        -- transparent BG
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      end
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
          theme = 'oxocarbon',
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
