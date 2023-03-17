--------------------------
--- lsp and completion --- 
--------------------------

local cmp = require 'cmp'

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
            -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'snippy' },
        }, {
            { name = 'buffer' },
        })
    })
end

vim.o.completeopt = "menuone,noselect"

-- capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Mappings.
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- neovim lsp
require("neodev").setup({})
local lsp = require 'lspconfig'

--> C
lsp.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
--> Clojure
lsp.clojure_lsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
--> Golang
lsp.gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { 'gopls' },
    -- for postfix snippets and analyzers
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        },
    },
})
--> html / css
lsp.html.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "htmldjango", "jinja.html" },
    settings = {
        rootMarkers = { "./git/", "README.md" }
    }
}
--> JavaScript (node)
lsp.tsserver.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
--> Python
lsp.pylsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
--> Svelte
lsp.svelte.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
--> lua
lsp.lua_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
-----------------------------------
