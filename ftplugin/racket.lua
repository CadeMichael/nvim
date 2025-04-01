local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("racket", {
  -- define
  s("def", fmt([[
(define ({}) {})
]], {
    i(1),
    i(0),
  })),
  s("match", fmt([[
(match {}
  [{}])
]], {
    i(1),
    i(0),
  }))
})
