-- autoisntall packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end
-- setup vim plug
local Plug = vim.fn["plug#"]
vim.call('plug#begin','~/.config/nvim/plugged')
  Plug 'jalvesaq/Nvim-R' -- R support
  Plug 'dense-analysis/ale' -- autoconfigured for lintr
  Plug 'junegunn/fzf.vim' -- fuzzy finding
  Plug 'simrat39/rust-tools.nvim'
vim.call('plug#end')

-- packer commands 
vim.cmd [[command! WhatHighlight :call util#syntax_stack()]]
vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

-- Language Server Configuration --

-- automatic lsp installer
require'lspinstall'.setup() -- important

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end

-- Required Plugins
local lsp = require "lspconfig"
local coq = require "coq"

-- Python
lsp.pyright.setup(coq.lsp_ensure_capabilities({}))
-- Lua
lsp.lua.setup(coq.lsp_ensure_capabilities({}))
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
	on_attach = on_attach,
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

-- TreeSitter
require'nvim-treesitter.configs'.setup {
    -- Modules and its options go here
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
}

-- global configurations --
vim.o.swapfile = false
vim.cmd("set termguicolors")
-- keymappings --
-- nvim tree
vim.api.nvim_set_keymap('n', '<Space>n',':NvimTreeToggle<CR>',{noremap = true, silent = true})
-- fzf
vim.api.nvim_set_keymap('n', '<C-Space>', ':FZF<CR>', {noremap= true, silent = true})
vim.api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '.', '.<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', ',', ',<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '[', '[<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '(', '(<C-g>u', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", {noremap = true, silent = true})
-- themeing
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.g.startify_custom_header = {
"  < Neovim time! >",
"   --------------",
"    \\",
"     \\",
"         .--.",
"        |o_o |",
"        |:_/ |",
"       //   \\ \\",
"      (|     | )",
"     /'\\_   _/`\\",
"     \\___)=(___/",
}
-- galaxy line --
require("cadeline")
