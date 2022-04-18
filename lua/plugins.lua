-- autoisntall packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

-- packer packages
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- packer
  use 'wbthomason/packer.nvim'
  -- lsp config
  use 'neovim/nvim-lspconfig'
  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup({
        -- Modules and its options go here
        highlight = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
      })
    end
  }
  -- colorchemes
  use "ellisonleao/gruvbox.nvim"
  use 'arcticicestudio/nord-vim'
  use {'kyazdani42/nvim-web-devicons'}
  -- fzf
  use 'junegunn/fzf' -- fzf
  use 'junegunn/fzf.vim' -- fuzzy finding
  use 'windwp/nvim-autopairs'
  -- lang support
  use 'lervag/vimtex' -- latex
  use 'mattn/emmet-vim'
  use 'hkupty/iron.nvim'
  -- lsp setup
  use 'dcampos/nvim-snippy'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'folke/trouble.nvim'
  -- nvim tree
  use "kyazdani42/nvim-tree.lua"
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
  use 'mhinz/vim-startify'
end)
