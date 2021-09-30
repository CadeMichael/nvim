-- LSP Configurations
-- Languages:
---- py -> pyright
---- js/ts -> typescript-language-server
------ svelte -> svelte-language-server
---- rs -> rust-analyzer
---- go -> gopls
---- hs -> haskell-language-server

-----------------------------------
-- automatic lsp installer
require'lspinstall'.setup() -- important

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end

-- Required Plugins
local lsp = require "lspconfig"
local coq = require "coq"

---- setup the keymappings for language server, from the lsp-config README 
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Python
lsp.pyright.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach,
}))
-- TypeScript
lsp.tsserver.setup(coq.lsp_ensure_capabilities({
	on_attatch = on_attach,
}))
-- Svelte
lsp.svelte.setup(coq.lsp_ensure_capabilities({
	on_attatch = on_attach,
}))
-- Lua
lsp.lua.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach,
}))
-- Haskell
lsp.hls.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach,
	root_dir = vim.loop.cwd,
	settings = {
		rootMarkers = {"./git/"}
	}
}))
-- Golang
lsp.gopls.setup(coq.lsp_ensure_capabilities({
	on_attach = on_attach,
	cmd = {'gopls'},
		-- for postfix snippets and analyzers
		capabilities = capabilities,
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
}))
-- Rust 
lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities({
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
}))
-----------------------------------
