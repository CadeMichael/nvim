---------------
-- Sourcing --
---------------

if vim.g.vscode then
  -- VSCode extension
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', 'U', '<C-r>', opts)
  vim.keymap.set('n', 'Y', 'y$', opts)
else
  require('keymaps')
  require('autocmd')

  --------------------
  -- Global Configs --
  --------------------
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.opt.hlsearch = false
  vim.opt.incsearch = true
  vim.opt.relativenumber = true
  vim.opt.number = true
  vim.opt.list = true
  vim.opt.colorcolumn = '80'
  vim.opt.smartindent = true
  vim.opt.swapfile = false
  vim.opt.expandtab = true
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2
  vim.opt.cursorline = true
  vim.opt.mouse = 'nv'

  -------------
  -- Plugins --
  -------------
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  local plugins = {
    require("plugs.lsp"),
    require("plugs.theme"),
    require("plugs.fuzzy"),
    require("plugs.lsp"),
    require("plugs.snips"),
    require("plugs.repl"),
    require("plugs.git"),
    require("plugs.editor")
  }

  require('lazy').setup(plugins)
end
