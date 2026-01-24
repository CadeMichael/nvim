return {
  {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup()
      vim.keymap.set('n', '<Space>td', '<cmd>Trouble diagnostics toggle<CR>', { desc = 'trouble diagnostic toggle' })
    end
  },
  {
    'neovim/nvim-lspconfig',
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

      local lsp_langs = {
        "clangd",
        "gopls",
        "koka",
        "pyright",
        "ts_ls",
      }

      vim.lsp.enable(lsp_langs)
    end,
  },
}
