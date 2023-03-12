---------------------
-- package management
---------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
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
    -- treesitter
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/playground',
    -- colorchemes
    'ellisonleao/gruvbox.nvim',
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('ide.syntax')
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
            local telescope_theme = "ivy"
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
        end,
    },
    -- lang support
    {
        'simrat39/rust-tools.nvim',
        config = function()
            local rt = require('rust-tools')
            rt.setup({
                tools = {
                    inlay_hints = {
                        auto = false,
                    },
                },
                server = {
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        vim.keymap.set("n",
                            "K",
                            rt.hover_actions.hover_actions,
                            { buffer = bufnr }
                        )
                        -- Code action groups
                        vim.keymap.set("n",
                            "<Leader>a",
                            rt.code_action_group.code_action_group,
                            { buffer = bufnr }
                        )
                        -- inlay hinting
                        vim.keymap.set("n",
                            "<Leader>h",
                            rt.inlay_hints.enable,
                            { buffer = bufnr }
                        )
                        vim.keymap.set("n",
                            "<Leader>uh",
                            rt.inlay_hints.disable,
                            { buffer = bufnr }
                        )
                        vim.keymap.set('n',
                            'gD',
                            vim.lsp.buf.declaration,
                            { buffer = bufnr })
                        vim.keymap.set('n',
                            'gd',
                            vim.lsp.buf.definition,
                            { buffer = bufnr })
                        vim.keymap.set('n',
                            '<space>D',
                            vim.lsp.buf.type_definition,
                            { buffer = bufnr })
                        vim.keymap.set('n',
                            '<space>rn', vim.lsp.buf.rename,
                            { buffer = bufnr })
                        vim.keymap.set('n',
                            'gr', vim.lsp.buf.references,
                            { buffer = bufnr })
                    end,
                },
            })
        end,
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end,
    },
    --  'lervag/vimtex',
    'mattn/emmet-vim',
    'preservim/nerdcommenter',
    'jpalardy/vim-slime',
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.presenter"] = {
                    config = {
                        zen_mode = "zen-mode",
                    }
                },
            },
        },
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    -- ({["''"]}) management,
    {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup()
        end,
    },
    -- tables / GUI,
    'dhruvasagar/vim-table-mode',
    { 'folke/zen-mode.nvim',
        config = function()
            require("zen-mode").setup()
        end
    },
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
        "folke/which-key.nvim",
        config = function()
            require('which-key').setup({
                window = {
                    border = 'double'
                }
            })
        end,
    }
})
