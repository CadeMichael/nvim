-- get the plugins
require("plugins")

-- global configurations --
vim.o.swapfile = false

vim.cmd("set rnu")
vim.cmd("set nohlsearch")
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- Source the lsp Setup
require("lspconf")

-- treesitter based tags
-- require'aerial'.setup()
-- folding
vim.o.foldmethod="expr"
vim.o.foldexpr="nvim_treesitter#foldexpr()"
vim.o.foldlevel = 32

-- auto pairs
require('nvim-autopairs').setup()

-- nvim tree
require('nvim-tree').setup()

-- keymappings --
local keymap = vim.api.nvim_set_keymap
keymap('n', '<Space>n',':NvimTreeToggle<CR>',{noremap = true, silent = true})
-- fzf
keymap('n', '<Space>.', ':FZF<CR>', {noremap= true, silent = true})
keymap('n', '<Space>,', ':FZF ../<CR>', {noremap= true, silent = true})
keymap('n', '<Space>b', ':Buffers<CR>', {noremap= true, silent = true})
-- lsp tagbar
--keymap('n', '<Space>t', ':AerialToggle()<CR>', {noremap= true, silent = true})
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
keymap('n', '<leader>t', ':lua OpenTerm() <CR>', {noremap = true, silent = true})

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
vim.o.background = "dark"
vim.opt.termguicolors = true
if vim.loop.os_uname().sysname ~= 'Darwin' then
  vim.cmd([[colorscheme nord]])
else
  vim.cmd([[colorscheme gruvbox]])
end

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

function OpenTerm()
  vim.cmd("bel split")
  vim.cmd("terminal")
  vim.cmd("setlocal nonumber norelativenumber")
end
