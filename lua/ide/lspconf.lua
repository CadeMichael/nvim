--------------------------
--- lsp and completion ---
--------------------------

-- locals
local cmp = require 'cmp'
local lsp = require 'lspconfig'
local tsb = require 'telescope.builtin'
local tst = require 'telescope.themes'
local used = require('langs')

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
      -- Accept currently selected item. Set `select` to `false` to only
      -- confirm explicitly selected items.
      ['<tab>'] = cmp.mapping.confirm({ select = true }),
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
  local function get_opts(desc)
    return { desc = desc, buffer = bufnr, noremap = true, silent = true }
  end
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
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
    tsb.lsp_references(tst.get_dropdown({}))
  end, get_opts("telescope get references"))
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end

-- neovim lsp
require("neodev").setup({})

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
--> lua
lsp.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
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
--> Scala
if used.Scala then
  local scala = require('metals').bare_config()
  scala.capabilities = require("cmp_nvim_lsp").default_capabilities()
  scala.on_attach = function(client, buffer)
    require("metals").setup_dap()
    on_attach(client, buffer)
  end

  local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
  vim.api.nvim_create_autocmd("filetype", {
    pattern = { "scala", "sbt", "java" },
    callback = function()
      require("metals").initialize_or_attach(scala)
    end,
    group = nvim_metals_group,
  })
end
--> Solidity
if used.Sol then
  lsp.solc.setup({
    capabilities = capabilities,
    on_attach = on_attach,
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
