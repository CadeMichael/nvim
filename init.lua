-- source local files
require('keymaps')
require('autocmd')

-- globals
vim.g.loaded_netrw = 1
vim.opt.number = true
vim.opt.signcolumn = 'auto'
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

-- lazy installer
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

-- load plugs
require("lazy").setup({
  spec = {
    { import = "plugs" },
  },
})
