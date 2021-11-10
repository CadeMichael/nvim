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
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- setup vim plug
local Plug = vim.fn["plug#"]
vim.call('plug#begin','~/.config/nvim/plugged')
  Plug 'jalvesaq/Nvim-R' -- R support
  Plug 'dense-analysis/ale' -- autoconfigured for lintr
  Plug 'junegunn/fzf' -- fzf
  Plug 'junegunn/fzf.vim' -- fuzzy finding
  Plug 'simrat39/rust-tools.nvim'
  Plug('Olical/conjure', {tag = 'v4.25.0'})
  Plug 'windwp/nvim-autopairs'
  Plug 'akinsho/bufferline.nvim'
  Plug 'hkupty/iron.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
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
-- folding 
vim.o.foldmethod="expr"
vim.o.foldexpr="nvim_treesitter#foldexpr()"
vim.o.foldlevel = 32

-- auto pairs 
require('nvim-autopairs').setup() --> optional more advanced / comp specific configs

-- keymappings --
local keymap = vim.api.nvim_set_keymap
-- nvim tree
keymap('n', '<Space>n',':NvimTreeToggle<CR>',{noremap = true, silent = true})
-- fzf
keymap('n', '<Space>.', ':FZF<CR>', {noremap= true, silent = true})
keymap('n', '<Space>,', ':FZF ../<CR>', {noremap= true, silent = true})
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
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme dracula]])
-- lua-line
require("line")
-- buffer-line
require("bufferline").setup{
  options = {
    always_show_bufferline = false,
    show_close_icon = false,
    show_buffer_close_icons = false,
    right_mouse_command = "buffer %d",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Tree",
        highlight = "Directory",
        text_align = "left"
      }
    }
  }
}
--> allowing mouse support
vim.o.mouse = 'nv' --> normal / visual

--> allowing partial running / repl experience 
-----
--> nvim iron
local iron = require'iron'
iron.core.add_repl_definitions {
  python = {
    mycustom = {
      lua_repl = {"lua"}
    }
  },
  javascript = {
    node_repl = {
      command = {"node"}
    }
  }
}
--> sniprun
require'sniprun'.setup({
  display = {"Classic", "VirtualTextOk"}
})
keymap('v', '<space>sr', '<Plug>SnipRun',{noremap = false, silent = true})
keymap('n', '<space>sc', '<Plug>SnipClose',{noremap = false, silent = true})
keymap('n', '<leader>sc', '<Plug>SnipReplMemoryClean',{noremap = false, silent = true})
keymap('n', '<leader>sr', '<Plug>SnipReset',{noremap = false, silent = true})
