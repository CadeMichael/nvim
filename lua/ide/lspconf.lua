--------------------------
--- lsp and completion ---
--------------------------

-- locals
local cmp = require 'cmp'
local lsp = require 'lspconfig'
local tsb = require 'telescope.builtin'
local tst = require 'telescope.themes'

-- setting up and configuring cmp
if cmp then
  cmp.setup({
    snippet = {
      expand = function(args)
        require('snippy').expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      -- ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
end

vim.o.completeopt = "menuone,noselect"

-- capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(_, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', function()
    tsb.lsp_references(tst.get_dropdown({}))
  end, opts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '<space>E', function()
    tsb.diagnostics(tst.get_dropdown({}))
  end, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end

-- neovim lsp
require("neodev").setup({})

--> C
lsp.clangd.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
--> JavaScript (node)
lsp.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
--> lua
lsp.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
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
local rt = require('rust-tools')
rt.setup({
  tools = {
    inlay_hints = {
      auto = false,
    },
  },
  server = {
    on_attach = on_attach,
  },
})
--> Scala
local scala = require('metals').bare_config()
scala.capabilities = require("cmp_nvim_lsp").default_capabilities()
scala.on_attach = function(client, buffer) on_attach(client, buffer) end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("filetype", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(scala)
  end,
  group = nvim_metals_group,
})
--> Zig
lsp.zls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
-----------------------------------
