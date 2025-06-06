---------------
-- Sourcing --
---------------

require('keymaps')
require('autocmd')
require('lang_ft')

--------------------
-- Global Configs --
--------------------
vim.g.loaded_netrw = 1
vim.opt.number = true
vim.opt.signcolumn = 'auto:1'
vim.g.loaded_netrwPlugin = 1
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.colorcolumn = '80'
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.mouse = 'nv'
-- vim.opt.cursorline = true

-------------
-- Plugins --
-------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system(
    {
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      lazyrepo,
      lazypath
    }
  )
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugs" },
  },
})

-- experimental
-- local maker = require('ccmake')
-- vim.api.nvim_create_user_command("BrowseFiles", function()
  -- maker.browse(vim.fn.getcwd())
-- end, {})
