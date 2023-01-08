-- get plugins
require('plugins')

----------------
-- My Plugins --
----------------
require('cFuncs')
-- Salesforce
require('force')
-- Zig
vim.g.zig_settings = {
  test = '<space>tf',
  build = '<space>bf',
  save = { format = true, build = false },
}
----------------

-- get the autocommands
require('autocmd')

--------------------
-- global configs --
--------------------

vim.cmd [[set nohlsearch]]
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.list = true
-- set defaults
vim.opt.listchars:append({ eol = '↵', lead = "." })
vim.o.swapfile = false
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.opt.cursorline = true

-- slime
vim.g.slime_target = "neovim"

-- comments
vim.g.NERDSpaceDelims = 1

-- emmet vim
vim.g.user_emmet_install_global = 0

-- themeing
vim.g.startify_custom_header = {} -- no header

-- allowing mouse support
vim.o.mouse = 'nv' --> normal / visual

-----------------
-- Os Specific --
-----------------

-- LateX
-- if vim.loop.os_uname().sysname == 'Darwin' then
-- vim.g.vimtex_view_method = 'skim'
-- else
-- vim.g.vimtex_view_method = 'zathura'
-- end

---------------
-- Functions --
---------------

function SaveClipper()
  vim.cmd(":%s/ $//")
  vim.cmd(":w")
end

---- Send Buff
function SendBuf()
  local first = 1
  local last = vim.api.nvim_buf_line_count(0)
  -- vim.cmd(first .. "," .. last .. "SlimeSend")
  require 'sniprun.api'.run_range(first, last)
end
