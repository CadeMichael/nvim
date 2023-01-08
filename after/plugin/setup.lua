-- auto pairs
require('nvim-autopairs').setup()

-- statusline
require('lualine').setup({})

-- sniprun
require 'sniprun'.setup({
  selected_interpreters = { 'Lua_nvim', 'Python3_fifo' },
  repl_enable = { 'Python3_fifo' },
})

-- surround
require('nvim-surround').setup()

-- Telescope
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

-- which key
require('which-key').setup({
  window = {
    border = 'double'
  }
})
