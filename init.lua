-- get plugins
require('plugins')

----------------
-- My Plugins --
----------------
require('cFuncs')
-- Salesforce
require('force')
-- Zig
if vim.loop.os_uname == 'darwin' then
  vim.g.zig_settings = {
      test = '<space>tf',
      build = '<space>bf',
      save = { format = true, build = false },
  }
end
----------------

-- get the autocommands
require('autocmd')

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
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
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

-----------------------
-- General Functions --
-----------------------

function SaveClipper()
  vim.cmd("%s/ $//")
  vim.cmd("w")
end
