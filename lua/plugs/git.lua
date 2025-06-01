return {
  {
    'tpope/vim-fugitive',
    config = function ()
      Map('n', '<space>gd', '<cmd>Gvdiffsplit<CR>', Opts, 'git diff v-split')
      Map('n', '<space>G', '<cmd>Git<CR>', Opts, 'git fugitive')
    end
  },
}
