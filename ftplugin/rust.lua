-- Imports
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

-- Commands
local function build_func()
  Snacks.terminal.open('cargo -q build', { interactive = false })
end

vim.keymap.set('n', '<Space>cc', build_func, opts)

-- Snippets
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
