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
    "effekt-lang/effekt-neovim",
    init = function()
      if not vim.lsp.config["effekt"] then
        vim.lsp.config('effekt', {
          cmd = { "effekt", "--server" },
          filetypes = { "effekt" },
          root_markers = { "out/", "main.effekt" },
          cmd_cwd = vim.fs.root(0, { "out/", 'main.effekt' }),
          root_dir = vim.fs.root(0, { "out/", 'main.effekt' }),
        })
      end
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
      infoview = {
        goal_markers = { unsolved = '', accomplished = '✓' },
      },
    }
  },
  { dir = '~/Documents/pl/flixSummer/flix-nvim' },
}
