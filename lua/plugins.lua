vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- packer
  use 'wbthomason/packer.nvim'
  -- native lsp
  use 'neovim/nvim-lspconfig'
  -- lsp wrapper
  use { 'ms-jpq/coq_nvim', branch = 'coq'}
  -- galaxy bar 
  use {
  'glepnir/galaxyline.nvim',
    branch = 'main',
    -- your statusline
    config = function() require'my_statusline' end,
    -- some optional icons
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  -- colorchemes 
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
end)
