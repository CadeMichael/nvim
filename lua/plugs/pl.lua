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
  'lark-parser/vim-lark-syntax',
  'whonore/Coqtail',
  { dir = '~/Documents/pl/flixSummer/flix-nvim' },
}
