vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

--[[
-- Snippets
--]]
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local snippet_node = ls.snippet_node

local function nat_spec_comments(args)
  local params = vim.split(args[1][1], ",")
  local visibility = args[2][1]
  local nodes = {}
  for _, param in ipairs(params) do
    param = vim.trim(param)
    if param ~= "" then
      local parts = vim.split(vim.trim(param), "%s+")
      local var_name = parts[#parts]
      table.insert(nodes, t({ "/// @param " .. var_name, "" }))
    end
  end
  if string.find(visibility, "returns") then
    table.insert(nodes, t({ "/// @returns", "" }))
  end
  return snippet_node(nil, nodes)
end

ls.add_snippets("solidity", {
  s("function", fmt([[
{docs}function {}({}) {} {{
    {}
}}
]], {
    docs = d(1, nat_spec_comments, { 3, 4 }),
    i(2, "functionName"),
    i(3),
    i(4, "visibility"),
    i(0, "body")
  })),
})
