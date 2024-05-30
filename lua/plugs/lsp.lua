return {
  {
    'folke/trouble.nvim',
    config = function()
      require("trouble").setup {
        position = "right",
        icons = false,
        fold_closed = ">",
        fold_open = "v",
        indent_lines = false,
      }
    end
  },
  'folke/neodev.nvim',
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- lsp
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = "single",
        }
      )

      vim.diagnostic.config({
        float = {
          border = "rounded",
        },
      })
    end
  },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  {
    'hrsh7th/nvim-cmp',
    config = function()
      -- locals
      local cmp = require 'cmp'
      local lsp = require 'lspconfig'
      local configs = require 'lspconfig.configs'
      local tsb = require 'telescope.builtin'
      require('cmp.config')

      -- setting up and configuring cmp
      if cmp then
        cmp.setup({
          view = {
            docs = { auto_open = false }
          },
          snippet = {
            expand = function(args)
              require 'luasnip'.lsp_expand(args.body)
            end,
          },
          completion = {
            completeopt = 'menu,menuone,noinsert',
            max_item_count = 10
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<tab>'] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' }, -- lsp
            { name = 'luasnip' },  -- snippets
            { name = 'path' },     -- file paths
          }, {
            { name = 'buffer' },
          })
        })
      end

      -- capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local on_attach = function(_, bufnr)
        local function buf_set_option(...)
          vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { buffer = bufnr, noremap = true, silent = true }
        local function get_opts(desc)
          return { desc = desc, buffer = bufnr, noremap = true, silent = true }
        end
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
        vim.keymap.set('n', '<space>f', vim.lsp.buf.format, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, get_opts("lsp list workspace folders"))
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition,
          get_opts("get type definition"))
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, get_opts("rename"))
        vim.keymap.set('n', 'gr', function()
          tsb.lsp_references()
        end, get_opts("telescope get references"))
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
        -- Trouble / linting
        vim.keymap.set('n', '<Space>tt', "<cmd> TroubleToggle<CR>", opts)
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float,
          get_opts("diagnostic open float"))
        vim.keymap.set('n', '<space>E', tsb.diagnostics, get_opts("telescope diagnostics"))
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      end

      --> lua
      -- neovim lsp
      require("neodev").setup({})
      lsp.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }
      --> C
      lsp.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      --> Go
      lsp.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      --> JavaScript (node)
      lsp.tsserver.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      --> Nim
      lsp.nim_langserver.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }
      --> Ocaml
      lsp.ocamllsp.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }
      --> Python
      lsp.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      --> Rust
      lsp.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      --> Svelte
      lsp.svelte.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      --> Solidity
      configs.solidity = {
        default_config = {
          cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
          filetypes = { 'solidity' },
          root_dir = require("lspconfig.util").root_pattern "foundry.toml",
          single_file_support = true,
        },
      }

      lsp.solidity.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end,
  },
}
