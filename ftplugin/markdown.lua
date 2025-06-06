local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

-- Keybindings
keymap({ 'n', 'i' }, '<C-c><C-c>', '<cmd>MdEval<CR>', opts)
keymap({ 'n' }, '<C-c>p', '<cmd>Presenting<CR>', opts)

-- Snippets
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("markdown", {
  s("<s", fmt([[
  ```<>
  <>
  ```
  ]], {
    i(1, "lang"),
    i(0),
  }, {
    delimiters = "<>"
  })),
})
