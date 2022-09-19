-- my plugins
require('compile')
-- autoisntall packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
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
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
  }
  -- colorchemes
  use 'Mofiqul/dracula.nvim'
  use { 'kyazdani42/nvim-web-devicons' }
  use 'nvim-lualine/lualine.nvim'
  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- lang support
  use 'windwp/nvim-autopairs'
  use 'lervag/vimtex' -- latex
  use 'mattn/emmet-vim'
  use 'preservim/nerdcommenter'
  use 'jpalardy/vim-slime'
  use 'olical/conjure'
  -- ({["''"]}) management
  use({
    'kylechui/nvim-surround',
    tag = '*',
  })
  -- lsp setup
  use 'dcampos/nvim-snippy'
  use 'dcampos/cmp-snippy'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'folke/trouble.nvim'
  -- nvim tree
  use 'kyazdani42/nvim-tree.lua'
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
  -- RestClient
  use {
    'NTBBloodbath/rest.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('rest-nvim').setup({
        -- Open request results in a horizontal split
        result_split_horizontal = true,
        -- Keep the http file buffer above|left when split horizontal|vertical
        result_split_in_place = true,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          show_http_info = true,
          show_headers = true,
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end
  }
end)
