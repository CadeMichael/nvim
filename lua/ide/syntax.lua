-------------
-- treesitter
-------------

require("nvim-treesitter.configs").setup({
  -- Modules and its options go here
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  ensure_installed = {
    "c",
    "clojure",
    "go",
    "javascript",
    "lua",
    "python",
    "rust",
    "elixir",
    "typescript",
    "zig",
  },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  indent = { enable = false },
  -- playground
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  additional_vim_regex_highlighting = true
})

-- folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 32
vim.cmd [[set nofoldenable]]
