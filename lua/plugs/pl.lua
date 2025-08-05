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
  {
    'whonore/Coqtail',
    event = { 'BufReadPre *.coq', 'BufNewFile *.coq' },
  },
  {
    'Julian/lean.nvim',
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
    },
    opts = {
      mappings = true,
    }
  },
  { dir = '~/Documents/pl/flixSummer/flix-nvim' },
}
