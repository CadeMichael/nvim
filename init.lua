---------------
-- Sourcing --
---------------

-- custom funcs
require('cFuncs')

-- Salesforce
require('force')

-- get plugins
require('config.plugins')

-- get keymaps
require('config.keymaps')

-- theme
require('config.theme')

-- get the autocommands
require('config.autocmd')

----------------

--------------------
-- global configs --
--------------------

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars:append({ eol = '↵' })
vim.opt.colorcolumn = '80'
vim.opt.smartindent = true
vim.o.swapfile = false
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.opt.cursorline = true
-- allowing mouse support
vim.o.mouse = 'nv' --> normal / visual
vim.g.slime_target = "tmux"
-- comments
vim.g.NERDSpaceDelims = 1
-- emmet vim
vim.g.user_emmet_install_global = 0
-- themeing
vim.g.startify_custom_header = {
    "   _   _         __     ___           ",
    "  | \\ | | ___  __\\ \\   / (_)_ __ ___  ",
    "  |  \\| |/ _ \\/ _ \\ \\ / /| | '_ ` _ \\ ",
    "  | |\\  |  __/ (_) \\ V / | | | | | | |",
    "  |_| \\_|\\___|\\___/ \\_/  |_|_| |_| |_|",
}
