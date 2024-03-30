--------------------------
--- lsp and completion ---
--------------------------
-- used configs
local used = require 'included'
-- locals
local cmp = require 'cmp'
local lsp = require 'lspconfig'
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
        require('snippy').expand_snippet(args.body) -- For `snippy` users.
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
      { name = 'snippy' },   -- snippets
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
end

--> lua
-- neovim lsp
require("neodev").setup({})
lsp.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
--> C
if used.Cpp then
  lsp.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end
--> JavaScript (node)
if used.Js then
  lsp.tsserver.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end
--> Nim
if used.Nim then
  lsp.nim_langserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end
--> Ocaml
if used.Ocaml then
  lsp.ocamllsp.setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end
--> Python
if used.Python then
  lsp.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end
--> Rust
if used.Rust then
  lsp.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end
--> Solidity
-- "npm install -g vscode-solidity-server"
if used.Solidity then
  lsp.solidity_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = require("lspconfig.util").root_pattern "foundry.toml",
  })
end
--> Zig
if used.Zig then
  lsp.zls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end
-----------------------------------
