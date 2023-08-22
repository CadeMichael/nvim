---------------------
-- package management
---------------------

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

require('lazy').setup({
    --lsp config
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    {
        'hrsh7th/nvim-cmp',
        config = function()
            require('ide.lspconf')
        end,
    },
    -- lsp extension
    {
        'dcampos/nvim-snippy',
        config = function()
            require('snippy').setup({
                mappings = {
                    is = {
                        ['<Tab>'] = 'expand_or_advance',
                        ['<S-Tab>'] = 'previous',
                    },
                    nx = {
                        ['<leader>x'] = 'cut_text',
                    },
                },
            })
        end,
    },
    'dcampos/cmp-snippy',
    'folke/trouble.nvim',
    'folke/neodev.nvim',
    -- debugging
    {
        'mfussenegger/nvim-dap',
        config = function()
            require('ide.debug')
        end
    },
    'rcarriga/nvim-dap-ui',
    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('ide.syntax')
        end,
    },
    'nvim-treesitter/playground',
    -- colorchemes
    'ellisonleao/gruvbox.nvim',
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'tokyonight',
                    component_separators = { left = '|', right = '|' },
                    section_separators = { left = ' ', right = ' ' },
                },
            })
        end
    },
    -- Telescope
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-dap.nvim',
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
            local telescope_theme = 'ivy'
            require('telescope').setup({
                -- set theme of used pickers
                pickers = {
                    git_files = {
                        theme = telescope_theme,
                    },
                    find_files = {
                        theme = telescope_theme,
                    },
                    buffers = {
                        theme = telescope_theme,
                    },
                    help_tags = {
                        theme = telescope_theme,
                    },
                    keymaps = {
                        theme = telescope_theme,
                    }
                }
            })
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('dap')
        end,
    },
    -- lang support
    {
        -- racket / lua
        'Olical/conjure',
        ft = {
            "racket",
            "python",
            "lua",
        },
        config = function()
            vim.g['conjure#extract#tree_sitter#enabled'] = true
        end
    },
    {
        -- rust
        'simrat39/rust-tools.nvim',
        config = function()
            require('ide.rust')
        end,
    },
    {
        -- scala
        'scalameta/nvim-metals'
    },
    {
        -- http
        'rest-nvim/rest.nvim',
        config = function()
            require('rest-nvim').setup()
        end
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end,
    },
    --  'lervag/vimtex',
    'mattn/emmet-vim',         -- html
    'alaviss/nim.nvim',        -- nim
    'preservim/nerdcommenter', -- comments
    'jpalardy/vim-slime',      -- repl
    -- ({['''']}) management,
    {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup()
        end,
    },
    -- tables
    'dhruvasagar/vim-table-mode',
    -- git,
    {
        'lewis6991/gitsigns.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('gitsigns').setup()
        end,
    },
    -- vim start screen,
    'mhinz/vim-startify',
    -- which key,
    {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup({
                window = {
                    border = 'double'
                }
            })
        end,
    }
})
