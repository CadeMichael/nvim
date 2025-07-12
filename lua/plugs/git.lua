return {
  {
    'tpope/vim-fugitive',
    config = function()
      Map('n', '<space>gd', '<cmd>Gvdiffsplit<CR>', Opts, 'git diff v-split')
      Map('n', '<space>G', '<cmd>Git<CR>', Opts, 'git fugitive')
    end
  },
  {
    "airblade/vim-gitgutter",
    config = function()
      vim.g.gitgutter_map_keys = 0
      Map("n", "<space>gg", "<cmd>GitGutterBufferToggle<CR>", Opts, "toggle git gutter")
      Map("n", "<space>gp", "<Plug>(GitGutterPreviewHunk)", Opts, "preview hunk")
      Map("n", "[h", "<Plug>(GitGutterPrevHunk)", Opts, "preview hunk")
      Map("n", "]h", "<Plug>(GitGutterNextHunk)", Opts, "preview hunk")
    end,
  },
}
