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

<<<<<<< HEAD
if vim.loop.os_uname().sysname ~= 'Darwin' then
  --vim.cmd("set termguicolors")
end
=======
--if vim.loop.os_uname().sysname ~= 'Darwin' then
  --vim.cmd("set termguicolors")
--end

>>>>>>> refs/remotes/origin/luaCmp
vim.cmd("set rnu")
vim.cmd("set nohlsearch")
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- setup vim plug
local Plug = vim.fn["plug#"]
vim.call('plug#begin','~/.config/nvim/plugged')
  Plug 'junegunn/fzf' -- fzf
  Plug 'junegunn/fzf.vim' -- fuzzy finding
  Plug 'windwp/nvim-autopairs'
  Plug "rebelot/kanagawa.nvim"
  Plug 'arcticicestudio/nord-vim'
  Plug 'preservim/tagbar'
  Plug 'hkupty/iron.nvim'
  --> langs
  Plug 'ray-x/go.nvim'
  Plug 'simrat39/rust-tools.nvim'
  Plug 'jalvesaq/Nvim-R' -- R support
  Plug 'lervag/vimtex' -- latex
  Plug 'hylang/vim-hy'
  Plug 'wlangstroth/vim-racket'
  Plug 'Olical/conjure'
  Plug 'mattn/emmet-vim'
  --> lsp setup
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'folke/trouble.nvim'
vim.call('plug#end')

-- Source the lsp Setup
require("lspconf")

-- get snippet Directory
vim.g.vsnip_snippet_dir = "~/.config/nvim/snips"

-- TreeSitter
require'nvim-treesitter.configs'.setup {
    -- Modules and its options go here
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
}
-- folding
vim.o.foldmethod="expr"
vim.o.foldexpr="nvim_treesitter#foldexpr()"
vim.o.foldlevel = 32

-- auto pairs
require('nvim-autopairs').setup() --> optional more advanced / comp specific configs

-- Dart / Flutter
require("flutter-tools").setup{} -- use defaults

-- keymappings --
local keymap = vim.api.nvim_set_keymap
-- nvim tree
require'nvim-tree'.setup{}
keymap('n', '<Space>n',':NvimTreeToggle<CR>',{noremap = true, silent = true})
-- fzf
keymap('n', '<Space>.', ':FZF<CR>', {noremap= true, silent = true})
keymap('n', '<Space>,', ':FZF ../<CR>', {noremap= true, silent = true})
keymap('n', '<Space>b', ':Buffers<CR>', {noremap= true, silent = true})
-- ctags
keymap('n', '<Space>t', ':TagbarToggle<CR>', {noremap= true, silent = true})
-- lsp tagbar
keymap('n', '<C-a>', ':AerialToggle<CR>', {noremap= true, silent = true})

-- clip ending white space and save
keymap('n', '<Space>s', ":lua SaveClipper()<CR>", {noremap = true, silent = true})
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

--> terminal integration
-- open terminal in split below
keymap('n', '<leader>t', [[:bel split | :terminal <CR>]], {noremap = true, silent = true})

--> themeing
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

-- colorscheme
vim.o.background = "dark" -- or "light" for light mode
<<<<<<< HEAD
vim.opt.termguicolors = true
vim.cmd([[colorscheme nord]])
=======
vim.cmd([[colorscheme kanagawa]])

>>>>>>> refs/remotes/origin/luaCmp
-- lua-line
require("lualine").setup()

--> allowing mouse support
vim.o.mouse = 'nv' --> normal / visual

--> allowing partial running / repl experience
-----
--> nvim iron
local iron = require'iron'
iron.core.add_repl_definitions {
  python = {
    lua_repl = {
      command = {"python"}
    }
  },
  lua = {
    lua_repl = {
      command = {"lua"}
    }
  },
  javascript = {
    node_repl = {
      command = {"deno"}
    }
  }
}

-- Neovide
vim.cmd([[set guifont=SauceCodePro\ Nerd\ Font:h14]])

---- Os Specific
-- LateX
if vim.loop.os_uname().sysname == 'Darwin' then
  vim.g.vimtex_view_method = 'skim'
else
  vim.g.vimtex_view_method = 'zathura'
end

---- Plugin Functions
function BetterIron()
  vim.cmd("IronRepl")
  vim.cmd("wincmd H")
end

function SaveClipper()
  vim.cmd(":%s/ $//")
  vim.cmd(":w")
end
