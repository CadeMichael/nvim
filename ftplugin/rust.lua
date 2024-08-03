-- Imports
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local opts = { noremap = true, silent = true }

-- Commands
local term_handler = vim.api.nvim_replace_termcodes(
  '<C-\\><C-n>G',
  true,
  true,
  true
)

local function build_func()
  vim.g.floaterm_autoclose = 0
  vim.cmd "FloatermNew cargo -q build"
  vim.api.nvim_feedkeys(term_handler, 'n', true)
  vim.g.floaterm_autoclose = 1
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
