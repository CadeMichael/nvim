-- get the plugins
require('plugins')

-- get the autocommands
require('autocmd')

-- get the lsp Setup
require("lspconf")

-- global configurations --
vim.cmd [[set nohlsearch]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = {}
vim.opt.listchars:append({ eol = '↵', lead = "." })
vim.o.swapfile = false
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- treesitter based tags
-- folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 32

-- slime
vim.g.slime_target = "neovim"

-- auto pairs
require('nvim-autopairs').setup()

-- nvim tree
require('nvim-tree').setup()

-- nvim surround
require('nvim-surround').setup()

-- Telescope
require('telescope').setup()
require('telescope').load_extension('fzf')

-- statusline
require('lualine').setup({})

-- which key
require('which-key').setup({
  window = {
    border = 'double'
  }
})

-- emmet vim
vim.g.user_emmet_install_global = 0

-- keymappings --
local keymap = vim.keymap.set

-- nvimtree
keymap('n', '<Space>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Telescope
keymap('n', '<Space>.', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
keymap('n', '<Space>bs', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
keymap('n', '<Space>h', '<cmd>Telescope help_tags<cr>', { noremap = true, silent = true })
keymap('n', '<Space>m', '<cmd>Telescope keymaps<cr>', { noremap = true, silent = true })
-- comments
keymap({ 'v', 'n' }, '<Space>;', "<Plug>NERDCommenterToggle", { noremap = true, silent = true })
vim.g.NERDSpaceDelims = 1
-- clip ending white space and save
keymap('n', '<Space>s', ":lua SaveClipper()<CR>", { noremap = true, silent = true })
-- slime
keymap('v', '<Space>r', "<Plug>SlimeRegionSend", { noremap = true, silent = true })
keymap('n', '<Space>l', "V<Plug>SlimeRegionSend$", { noremap = true, silent = true })
keymap('n', '<C-x><C-e>', "va(<Plug>SlimeRegionSend%", { noremap = true, silent = true })
-- Trouble
keymap('n', '<Space>tt', "<cmd> TroubleToggle<CR>", { noremap = true, silent = true })
-- Cht.sh
keymap('n', '<Space>cs', "<cmd> CheatSheet<CR>", { noremap = true, silent = true })
-- Compile
keymap('n', '<Space>cc', "<cmd> CompileCurrent<CR>", { noremap = true, silent = true })
-- Neogit
keymap('n', '<C-x>g', "<cmd> Neogit<CR>", { noremap = true, silent = true })
-- terminal
keymap({ 'n', 'i' }, '<C-c><C-z>', '<cmd> OpenTerm<CR>', { noremap = true, silent = true })
keymap('t', '<C-c><C-z>', '<C-\\><C-N> <cmd> OpenTerm<CR>]', { noremap = true, silent = true })
-- prevent nvim from being suspended
keymap({ 'n', 'i' }, '<C-z>', '<Esc>', { noremap = true, silent = true })

-- remaps
keymap('n', '<Space>bk', ':bdelete!<CR>', { noremap = true, silent = true })
keymap('n', 'Y', 'y$', { noremap = true, silent = true })
keymap('n', 'n', 'nzzzv', { noremap = true, silent = true })
keymap('n', 'N', 'Nzzzv', { noremap = true, silent = true })
keymap('i', '.', '.<C-g>u', { noremap = true, silent = true })
keymap('i', ',', ',<C-g>u', { noremap = true, silent = true })
keymap('i', '[', '[<C-g>u', { noremap = true, silent = true })
keymap('i', '(', '(<C-g>u', { noremap = true, silent = true })
keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

--> themeing
vim.g.startify_custom_header = {} -- no header

-- colorscheme
vim.opt.termguicolors = true
local dracula = require('dracula')
dracula.setup({
  transparent_bg = true,
})
vim.cmd [[colorscheme dracula]]

--> allowing mouse support
vim.o.mouse = 'nv' --> normal / visual

-- Neovide
vim.cmd([[set guifont=Hack\ Nerd\ Font:h16]])
vim.g.neovide_transparency = 0.85
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

---- Os Specific
-- LateX
if vim.loop.os_uname().sysname == 'Darwin' then
  vim.g.vimtex_view_method = 'skim'
else
  vim.g.vimtex_view_method = 'zathura'
end

---- Functions
function SaveClipper()
  vim.cmd(":%s/ $//")
  vim.cmd(":w")
end
