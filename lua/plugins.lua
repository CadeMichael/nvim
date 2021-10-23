vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- packer
  use 'wbthomason/packer.nvim'
  -- native lsp
  use 'neovim/nvim-lspconfig'
  -- lsp installer
  use {'kabouzeid/nvim-lspinstall'}
  -- lsp wrapper
  use { 'ms-jpq/coq_nvim', branch = 'coq'}
  -- galaxy bar 
  use {'kyazdani42/nvim-web-devicons'}
  -- lualine
  use{'nvim-lualine/lualine.nvim'}
  -- colorchemes 
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  use {"dracula/vim"}
  -- nvim tree
  use {
    "kyazdani42/nvim-tree.lua",
    config = function() 
      require'nvim-tree'.setup {} end
  }
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
  -- vim start screen
  use {'mhinz/vim-startify'}
  -- highlighting for languages
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate' 
  }
end)
