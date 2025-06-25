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
        preset = 'luasnip',
      },
      keymap = {
        preset = 'default',
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        }
      },
    },
    opts_extend = { 'sources.default' },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    enabled = true,
    config = function()
      require("lazydev").setup()
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      {
        "scalameta/nvim-metals",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        ft = { "scala", "sbt", "java" }
      },
    },
    config = function()
      -- show lsp diagnostics by highlighting line numbers
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
          },
        },
        severity_sort = true,
      })
      local on_attach = function(_, bufnr)
        -- Mappings.
        local function get_opts(desc)
          return { desc = desc, buffer = bufnr, noremap = true, silent = true }
        end
        -- formatting
        vim.keymap.set(
          'n',
          '<space>=',
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
        vim.keymap.set(
          'n',
          '<space>ee',
          vim.diagnostic.open_float,
          get_opts('diagnostic open float')
        )
        vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, get_opts('prev diagnostic'))
        vim.keymap.set('n', ']e', vim.diagnostic.goto_next, get_opts('next diagnostic'))
      end

      -- import lsp modules
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lsp = require('lspconfig')
      local lsp_configs = require('lspconfig.configs')
      local lsp_util = require('lspconfig.util')

      --> lua
      -- neovim lsp
      lsp.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach
      }
      --> C
      lsp.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })
      --> Coq
      lsp.coq_lsp.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })
      --> Effekt
      lsp_configs.effekt = {
        default_config = {
          cmd = { 'effekt', '--server' },
          filetypes = { 'effekt' },
          root_dir = lsp_util.root_pattern('*.effekt'),
        },
      }
      lsp.effekt.setup {
        capabilities = capabilities,
        on_attach = on_attach
      }
      --> Flix
      -- create flix config
      lsp_configs.flix = {
        default_config = {
          cmd = { "java", "-jar", "flix.jar", "lsp" },
          filetypes = { "flix" },
          root_dir = function(fname)
            local root_dir = vim.fs.dirname(vim.fs.find({ "flix.toml", "flix.jar" }, { path = fname, upward = true })[1])
                or vim.fs.dirname(fname)
            local flix_jar_path = vim.fs.joinpath(root_dir, "flix.jar")
            if vim.loop.fs_stat(flix_jar_path) == nil then
              print("Failed to start the LSP server: flix.jar not found in project root (" .. root_dir .. ")!\n")
              return nil
            end
            return root_dir
          end,
          settings = {},
        },
      }
      -- setup server
      lsp.flix.setup {
        capabilities = capabilities,
        on_attach = function(_, bufnr)
          -- flix specific pre attatch actions
          print("Flix LSP attached to buffer " .. bufnr)
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            pattern = "<buffer>",
            callback = function()
              vim.lsp.codelens.refresh({ bufnr = bufnr })
            end,
          })
          on_attach(_, bufnr)
        end,
      }
      --> Go
      lsp.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })
      --> JavaScript (node)
      lsp.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })
      --> koka
      lsp.koka.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      --> Lean4
      require('lean').setup {
        lsp = {
          capabilities = capabilities,
          on_attach = on_attach,
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
        on_attach = on_attach
      }
      --> Nix
      lsp.nixd.setup {
        capabilities = capabilities,
        on_attach = on_attach,
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
        on_attach = on_attach
      }
      --> Python
      lsp.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })
      --> Racket
      lsp.racket_langserver.setup({
        capabilities = capabilities,
        on_attach = on_attach(),
      })
      --> Rust
      lsp.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })
      --> Scala
      local metals_config = require("metals").bare_config()
      metals_config.on_attach = on_attach
      metals_config.capabilities = capabilities
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = require("metals").ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
      --> Svelte
      lsp.svelte.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })
      --> Zig
      lsp.zls.setup({
        capabilities = capabilities,
        on_attach = on_attach
      })
    end,
  },
}
-- test
