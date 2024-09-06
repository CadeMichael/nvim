local keymap = vim.keymap.set
keymap('n', '<Space>cn', '<cmd>CoqNext<CR>', { desc = "CoqNext" })
keymap('n', '<Space>cq', '<cmd>CoqStop<CR>', { desc = "CoqStop" })
keymap('n', '<Space>cs', '<cmd>CoqStart<CR>', { desc = "CoqStart" })
keymap('n', '<Space>cu', '<cmd>CoqUndo<CR>', { desc = "CoqUndo" })

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("coq", {
  s("forall", fmt([[
∀ {}
]], {
    i(0),
  })),
  s("exists", fmt([[
∃ {}
]], {
    i(0),
  })),
})
