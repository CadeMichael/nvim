-- autoisntall packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- packer commands 
vim.cmd [[command! WhatHighlight :call util#syntax_stack()]]
vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

-- global configurations --
vim.o.swapfile = false
vim.cmd("set termguicolors")
vim.cmd("set rnu")
vim.cmd("set nohlsearch")
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

-- setup vim plug
local Plug = vim.fn["plug#"]
vim.call('plug#begin','~/.config/nvim/plugged')
  Plug 'jalvesaq/Nvim-R' -- R support
  Plug 'dense-analysis/ale' -- autoconfigured for lintr
  Plug 'junegunn/fzf.vim' -- fuzzy finding
  Plug 'simrat39/rust-tools.nvim'
vim.call('plug#end')

-- Source the lsp Setup
require("lspconf")

-- TreeSitter
require'nvim-treesitter.configs'.setup {
    -- Modules and its options go here
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
}

-- keymappings --
local keymap = vim.api.nvim_set_keymap
-- nvim tree
keymap('n', '<Space>n',':NvimTreeToggle<CR>',{noremap = true, silent = true})
-- fzf
keymap('n', '<Space>.', ':FZF<CR>', {noremap= true, silent = true})
-- COQ
keymap('n', '<C-q>', ':COQnow -s<CR>', {noremap= true, silent = true})
-- remaps
keymap('n', 'Y', 'y$', {noremap = true, silent = true})
keymap('n', 'n', 'nzzzv', {noremap = true, silent = true})
keymap('n', 'N', 'Nzzzv', {noremap = true, silent = true})
keymap('i', '.', '.<C-g>u', {noremap = true, silent = true})
keymap('i', ',', ',<C-g>u', {noremap = true, silent = true})
keymap('i', '[', '[<C-g>u', {noremap = true, silent = true})
keymap('i', '(', '(<C-g>u', {noremap = true, silent = true})
keymap('v', 'J', ":m '>+1<CR>gv=gv", {noremap = true, silent = true})
keymap('v', 'K', ":m '<-2<CR>gv=gv", {noremap = true, silent = true})
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
