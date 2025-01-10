return {
  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup({})
      vim.keymap.set('n', '<Space>td', '<cmd>Trouble diagnostics toggle<CR>', { desc = 'trouble diagnostic toggle' })
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
      keymap = {
        preset = 'default',
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
    opts_extend = { 'sources.default' },
  },
  'folke/neodev.nvim', -- lua
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      local tsb = require('telescope.builtin')
      local on_attach = function(_, bufnr)
        -- Mappings.
        local function get_opts(desc)
          return { desc = desc, buffer = bufnr, noremap = true, silent = true }
        end
        -- formatting
        vim.keymap.set(
          'n',
          '<space>f',
          function()
            vim.lsp.buf.format()
          end,
          get_opts('format buffer')
        )
        -- renaming
        vim.keymap.set(
          'n',
          '<space>rn',
          function()
            vim.lsp.buf.rename()
          end,
          get_opts('rename')
        )
        -- gotos
        vim.keymap.set(
          'n',
          'gd',
          function()
            vim.lsp.buf.definition()
          end,
          get_opts('goto definition')
        )
        vim.keymap.set('n',
          'gr',
          function()
            tsb.lsp_references()
          end,
          get_opts('telescope get references')
        )
        -- diagnostics
        vim.keymap.set(
          'n',
          '<space>E',
          tsb.diagnostics,
          get_opts('telescope diagnostics')
        )
        vim.keymap.set(
          'n',
          '<space>ee',
          vim.diagnostic.open_float,
          get_opts('diagnostic open float')
        )
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, get_opts('prev diagnostic'))
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, get_opts('next diagnostic'))
      end

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lsp = require('lspconfig')

      --> lua
      -- neovim lsp
      require("neodev").setup({})
      lsp.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach
      }
      --> C
      lsp.clangd.setup({
        capabilities = capabilities,
      })
      --> Coq
      lsp.coq_lsp.setup({
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
            ['textDocument/publishDiagnostics'] = vim.lsp.with(
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
              command = { 'nixfmt' },
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
