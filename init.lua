-- get the plugins
require("plugins")

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

-- treesitter
require 'nvim-treesitter.configs'.setup({
  -- Modules and its options go here
  highlight = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    colors = {
      "#8be9fd", -- cyan 
      "#ff79c6", -- pink
      "#bd93f9", -- purple 
      "#6272a4", -- comment (light navy)
      "#ffb86c", -- orange
      "#50fa7b", -- green
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
-- vim.o.background = "dark"
vim.g.dracula_transparent_bg = true
vim.opt.termguicolors = true
--if vim.loop.os_uname().sysname == 'Darwin' then
  --vim.cmd[[colorscheme gruvbox]]
--else
vim.cmd[[colorscheme dracula]]
--end
-- statusline
require'lualine'.setup()

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

-- autocmd's
if vim.fn.has "nvim-0.7" ~= 0 then
  -- emmet
  vim.api.nvim_create_autocmd(
    "FileType",
    {
      pattern = { "html", "css" },
      command = "EmmetInstall",
    }
  )
  -- term line num
  vim.api.nvim_create_autocmd(
    "TermOpen",
    {
      pattern = "*",
      command = "setlocal nonumber norelativenumber",
    }
  )
else
  -- emmet
  vim.cmd "autocmd Filetype html,css EmmetInstall"
  -- term line num
  vim.cmd "autocmd TermOpen * setlocal nonumber norelativenumber"
end

-- Neovide
vim.g.neovide_transparency = 0.9
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
