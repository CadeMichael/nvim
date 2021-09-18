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
    --config = function() require'cadeline.lua' end,
    -- some optional icons
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  -- colorchemes 
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  -- nvim tree
  use {"kyazdani42/nvim-tree.lua"}
  -- git 
  use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    require('gitsigns').setup()
  end
  }
  use {'mhinz/vim-startify'}
  use {'kabouzeid/nvim-lspinstall'}
end)
