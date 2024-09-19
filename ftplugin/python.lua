local keymap = vim.keymap.set

local function blackFormat()
  local file = vim.api.nvim_buf_get_name(0)
  vim.cmd("!black -q " .. file)
end

local function runPyBuffer()
  local file = vim.api.nvim_buf_get_name(0)
  vim.cmd("!python " .. file)
end

local bufnr = vim.api.nvim_get_current_buf()
keymap('n', '<Space>bf', blackFormat, { buffer = bufnr, desc = "black format" })
keymap('n', '<Space>rb', runPyBuffer, { buffer = bufnr, desc = "run python buffer" })


local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local isn = ls.indent_snippet_node
local f = ls.function_node
local k = require('luasnip.nodes.key_indexer').new_key
local fmt = require("luasnip.extras.fmt").fmt

local function parse_params(str)
  local params = {}
  local balance = 0
  local param = {}
  -- Iterate over each character.
  for j = 1, #str do
    local char = str:sub(j, j)
    if char == '[' then
      balance = balance + 1
    elseif char == ']' then
      balance = balance - 1
    end
    -- If a comma not within brackets is found, split here.
    if char == ',' and balance == 0 then
      table.insert(params, table.concat(param))
      param = {}
    else
      table.insert(param, char)
    end
  end
  -- Insert the last parameter.
  table.insert(params, table.concat(param))
  return params
end

local function doc_string(args)
  local raw_params = args[1][1]
  local params = parse_params(raw_params)
  local nodes = {}
  for _, param in ipairs(params) do
    param = vim.trim(param)
    if param ~= "" then
      local parts = vim.split(vim.trim(param), ":")
      local var_name = vim.trim(parts[1])
      if #parts > 1 then
        local type_name = vim.trim(parts[2])
        table.insert(nodes, (var_name .. ' (' .. type_name .. '):'))
      else
        table.insert(nodes, (var_name .. ' '))
      end
    end
  end
  return nodes
end

ls.add_snippets("python", {
  s("dd", fmt([[
def {}({}):
    """{}

    Args:
        {}
    """

    {}
]], {
    i(1, "name"),
    i(2, "params", { key = "p-key" }),
    i(3, "desc"),
    isn(nil, { f(doc_string, k("p-key")) }, "$PARENT_INDENT\t\t"),
    i(0, "body")
  })),
  s("lc", fmt([[
{} = [{} for {} in {}]
  ]], {
    i(1, "var"),
    i(2, "element"),
    i(3, "element"),
    i(0, "list"),
  })),
})
