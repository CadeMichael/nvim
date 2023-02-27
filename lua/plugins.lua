---------------------
-- package management
---------------------

-- packer packages
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- packer
  use 'wbthomason/packer.nvim'
  -- tmux
  use 'christoomey/vim-tmux-navigator'
  -- lsp config
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  -- lsp extension
  use 'dcampos/nvim-snippy'
  use 'dcampos/cmp-snippy'
  use 'folke/trouble.nvim'
  -- treesitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/playground'
  -- colorchemes
  use 'ellisonleao/gruvbox.nvim'
  -- Telescope
  use {
      'nvim-telescope/telescope.nvim', tag = '*',
  }
  use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make'
  }
  -- lang support
  use 'simrat39/rust-tools.nvim'
  use 'windwp/nvim-autopairs'
  -- use 'lervag/vimtex'
  use 'mattn/emmet-vim'
  use 'preservim/nerdcommenter'
  use 'jpalardy/vim-slime'
  -- ({["''"]}) management
  use({
      'kylechui/nvim-surround',
      tag = '*',
  })
  -- tables
  use 'dhruvasagar/vim-table-mode'
  -- git
  use {
      'TimUntersberger/neogit',
      config = function()
        require('neogit').setup()
      end
  }
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
  use 'mhinz/vim-startify'
  -- which key
  use "folke/which-key.nvim"
end)
