if not vim.g.vscode then
  local ls = require("luasnip")
  local s = ls.snippet
  local i = ls.insert_node
  local fmt = require("luasnip.extras.fmt").fmt

  ls.add_snippets("rust", {
    -- let
    s("let", fmt([[
let {} = {};
]], {
      i(1, "var"),
      i(0, "val"),
    })),
    -- match
    s("match", fmt([[
match {} {{
    {} => {}
}};
]], {
      i(1, "value"),
      i(2, "case"),
      i(0),
    })),
    -- functions
    s("fn", fmt([[
fn {}({}){} {{
    {}
}}
]], {
      i(1, "name"),
      i(2, "params"),
      i(3),
      i(0),
    })),
    -- pub functions
    s("pfn", fmt([[
pub fn {}({}){} {{
    {}
}}
]], {
      i(1, "name"),
      i(2, "params"),
      i(3),
      i(0),
    })),
  })
end
