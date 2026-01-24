return {
  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup()
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
    opts = {
      snippets = {
        preset = 'luasnip',
      },
      keymap = {
        preset = "default",
        ["<C-y>"] = false,
        ['<Tab>'] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          'snippet_forward',
          'fallback'
        },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
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

      -- customized mappings
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local function get_opts(desc)
            return { desc = desc, buffer = args.buf, noremap = true, silent = true }
          end
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          if client:supports_method('textDocument/format') then
            vim.keymap.set('n', '<space>=', vim.lsp.buf.format, get_opts('format buffer'))
          end
          if client:supports_method('textDocument/rename') then
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, get_opts('rename'))
          end
          vim.keymap.set('n', '<space>ee', vim.diagnostic.open_float, get_opts('diagnostic open float'))
        end
      })

      require("flix").setup()

      local lsp_langs = {
        "clangd",
        "coq_lsp",
        "effekt",
        "flix",
        "gopls",
        "koka",
        "lua_ls",
        "metals",
        "nixd",
        "phpactor",
        "pyright",
        "ocamllsp",
        "racket_langserver",
        "rust_analyzer",
        "ts_ls",
        "zls",
      }

      vim.lsp.enable(lsp_langs)
    end,
  },
}
