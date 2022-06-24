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
  },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
})

-- keymappings --
local keymap = vim.keymap.set

keymap('n', '<Space>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
--fzf
keymap('n', '<Space>.', ':FZF<CR>', { noremap = true, silent = true })
keymap('n', '<Space>,', ':FZF ../<CR>', { noremap = true, silent = true })
keymap('n', '<Space>b', ':Buffers<CR>', { noremap = true, silent = true })
-- comments
keymap({ 'v', 'n' }, '<Space>;', "<Plug>NERDCommenterToggle", { noremap = true, silent = true })
-- rest client
keymap('n', '<Space>R', "<Plug>RestNvim", { noremap = true, silent = true })
-- clip ending white space and save
keymap('n', '<Space>s', ":lua SaveClipper()<CR>", { noremap = true, silent = true })
-- slime
keymap('v', '<Space>r', "<Plug>SlimeRegionSend", { noremap = true, silent = true })

-- remaps
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
vim.o.background = "dark"
vim.opt.termguicolors = true
if vim.loop.os_uname().sysname ~= 'Darwin' then
  vim.cmd([[colorscheme nord]])
else
  vim.cmd([[colorscheme gruvbox]])
end

--> allowing mouse support
vim.o.mouse = 'nv' --> normal / visual

-- Neovide
vim.cmd([[set guifont=SauceCodePro\ Nerd\ Font:h16]])

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

-- vimwiki
vim.g.vimwiki_list = {
  {
    path = '/Users/cadelueker/Desktop/wiki/src/pages/',
    index = 'index',
    syntax = 'markdown',
    ext = '.md',
  }
}

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
