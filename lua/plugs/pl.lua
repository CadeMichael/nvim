return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      if vim.fn.has("macunix") == 1 then
        vim.g.vimtex_view_method = "skim"
      else
        vim.g.vimtex_view_method = "zathura"
      end
      vim.g.tex_conceal = 'abdmg'
    end
  },
  'whonore/Coqtail', -- Coq
  {                  -- Haskell
    'mrcjkb/haskell-tools.nvim',
    version = '^4',  -- Recommended
    lazy = false,    -- This plugin is already lazy
  },
  {
    'Julian/lean.nvim', -- Lean4
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
    },
    opts = {
      lsp = {},
      mappings = false,
    }
  },
  'souffle-lang/souffle.vim' -- Souffle Datalog
}
