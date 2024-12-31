return {
  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup({})
      vim.keymap.set('n', '<Space>td', "<cmd>Trouble diagnostics toggle<CR>", { desc = "trouble diagnostic toggle" })
    end
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    -- !Important! Make sure you're using the latest release of LuaSnip
    -- `main` does not work at the moment
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    version = '*',
    ---@module 'blink.cmp'
    opts = {
      snippets = {
        expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction) require('luasnip').jump(direction) end,
      },
      keymap = { preset = 'default' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
    opts_extend = { "sources.default" }
  },
  'folke/neodev.nvim', -- lua
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lsp = require('lspconfig')
      --> lua
      -- neovim lsp
      require("neodev").setup({})
      lsp.lua_ls.setup {
        capabilities = capabilities,
      }
      --> C
      lsp.clangd.setup({
        capabilities = capabilities,
      })
      --> Coq
      lsp.coq_lsp.setup({
        capabilities = capabilities,
      })
      --> Dafny
      lsp.dafny.setup({
        capabilities = capabilities,
      })
      --> Go
      lsp.gopls.setup({
        capabilities = capabilities,
      })
      --> JavaScript (node)
      lsp.ts_ls.setup({
        capabilities = capabilities,
      })
      --> Lean4
      require('lean').setup {
        lsp = {
          capabilities = capabilities,
          handlers = {
            ["textDocument/publishDiagnostics"] = vim.lsp.with(
              vim.lsp.diagnostic.on_publish_diagnostics, {
                -- Disable virtual_text
                virtual_text = false
              }
            ),
          }
        }
      }
      --> Nim
      lsp.nim_langserver.setup {
        capabilities = capabilities,
      }
      --> Nix
      lsp.nixd.setup {
        capabilities = capabilities,
        settings = {
          nixd = {
            formatting = {
              command = { "nixfmt" },
            },
          },
        },
      }
      --> Ocaml
      lsp.ocamllsp.setup {
        capabilities = capabilities,
      }
      --> Python
      lsp.pyright.setup({
        capabilities = capabilities,
      })
      --> Rust
      lsp.rust_analyzer.setup({
        capabilities = capabilities,
      })
      --> Svelte
      lsp.svelte.setup({
        capabilities = capabilities,
      })
      --> Zig
      lsp.zls.setup({
        capabilities = capabilities,
      })
    end,
  },
}
