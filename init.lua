-- get the plugins
require("plugins")

-- get the autocommands
require("autocmd")

-- global configurations --
vim.o.swapfile = false

vim.cmd("set rnu")
vim.cmd("set nohlsearch")
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- treesitter based tags
-- folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 32

-- Source the lsp Setup
require("lspconf")

-- slime
vim.g.slime_target = "neovim"

-- auto pairs
require('nvim-autopairs').setup()

-- nvim tree
require('nvim-tree').setup()

-- Telescope
require('telescope').setup()
require('telescope').load_extension('fzf')

-- treesitter
require 'nvim-treesitter.configs'.setup({
  -- Modules and its options go here
  highlight = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    colors = {
      "#bd93f9",
      "#ff79c6",
      "#8be9fd",
      "#6272a4",
      "#ff5555",
    },
  },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
})

-- keymappings --
local keymap = vim.keymap.set

keymap('n', '<Space>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Telescope
keymap('n', '<Space>.', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
keymap('n', '<Space>b', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
keymap('n', '<Space>h', '<cmd>Telescope help_tags<cr>', { noremap = true, silent = true })
-- comments
keymap({ 'v', 'n' }, '<Space>;', "<Plug>NERDCommenterToggle", { noremap = true, silent = true })
vim.g.NERDSpaceDelims = 1
-- rest client
keymap('n', '<Space>R', "<Plug>RestNvim", { noremap = true, silent = true })
-- clip ending white space and save
keymap('n', '<Space>s', ":lua SaveClipper()<CR>", { noremap = true, silent = true })
-- slime
keymap('v', '<Space>r', "<Plug>SlimeRegionSend", { noremap = true, silent = true })
-- Trouble
keymap('n', '<Space>!', ":TroubleToggle<CR>", { noremap = true, silent = true })
-- Compile
keymap('n', '<Space>cc', ":CompileCurrent<CR>", { noremap = true, silent = true })


-- remaps
keymap('n', '<leader>kk', ':bdelete!<CR>', { noremap = true, silent = true })
keymap('n', 'Y', 'y$', { noremap = true, silent = true })
keymap('n', 'n', 'nzzzv', { noremap = true, silent = true })
keymap('n', 'N', 'Nzzzv', { noremap = true, silent = true })
keymap('i', '.', '.<C-g>u', { noremap = true, silent = true })
keymap('i', ',', ',<C-g>u', { noremap = true, silent = true })
keymap('i', '[', '[<C-g>u', { noremap = true, silent = true })
keymap('i', '(', '(<C-g>u', { noremap = true, silent = true })
keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

--> terminal integration
-- open terminal in split below
keymap('n', '<leader>t', ':lua OpenTerm() <CR>', { noremap = true, silent = true })

--> themeing
vim.g.startify_custom_header = {} -- no header

-- colorscheme
vim.g.dracula_transparent_bg = true
vim.opt.termguicolors = true
vim.cmd [[colorscheme dracula]]

-- statusline
require("lualine").setup({})

--> allowing mouse support
vim.o.mouse = 'nv' --> normal / visual

-- Neovide
vim.cmd([[set guifont=Hack\ Nerd\ Font:h16]])

---- Os Specific
-- LateX
if vim.loop.os_uname().sysname == 'Darwin' then
  vim.g.vimtex_view_method = 'skim'
else
  vim.g.vimtex_view_method = 'zathura'
end

---- Plugin Functions
function SaveClipper()
  vim.cmd(":%s/ $//")
  vim.cmd(":w")
end

function OpenTerm()
  vim.cmd("bel split")
  vim.cmd("terminal")
end

-- emmet vim
vim.g.user_emmet_install_global = 0

-- LateX
if vim.loop.os_uname().sysname == 'Darwin' then
  vim.g.vimtex_view_method = 'skim'
else
  vim.g.vimtex_view_method = 'zathura'
end

-- Neovide
vim.g.neovide_transparency = 0.85
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
