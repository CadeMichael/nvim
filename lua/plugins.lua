vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- packer
  use 'wbthomason/packer.nvim'
  -- native lsp
  use 'neovim/nvim-lspconfig'
  -- lsp wrapper
  use { 'ms-jpq/coq_nvim', branch = 'coq'}
end)
