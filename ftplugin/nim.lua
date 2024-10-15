-- imports
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local bufnr_opt = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr_opt }
----------

---@type string
local test_cmd = "nim c -r "
---@type vim.treesitter.Query
local q = vim.treesitter.query.parse("nim", [[
    (call
      (identifier) @name (#eq? @name "test")
      (argument_list
        (interpreted_string_literal) @test_name))
    ]])

-- get the root node of the AST
---@param bufnr integer
---@return TSNode
local get_root = function(bufnr)
  ---@type vim.treesitter.LanguageTree
  local parser = vim.treesitter.get_parser(bufnr, "nim", {})
  ---@type TSTree
  local tree = parser:parse()[1]
  return tree:root()
end

-- handle raw stdout / stderr data and present to user
---@param data string[]
local function handle_data(data)
  ---@type string
  local msg = ""
  for _, v in ipairs(data) do
    msg = msg .. v .. "\n"
  end
  if #msg > 1 then
    vim.api.nvim_notify(msg, vim.log.levels.INFO, {})
  end
end

-- test given function name from current nim buffer
---@param fname string
local function test_function(fname)
  ---@type string
  local bufname = vim.api.nvim_buf_get_name(0)
  ---@type string
  local command = test_cmd .. bufname .. " " .. fname
  vim.fn.jobstart(command, {
    stderr_buffered = true,
    stdout_buffered = true,
    on_stdout = function(_, data)
      if #data > 1 then
        handle_data(data)
      end
    end,
  })
end

-- create a picker to pick a function name from the current file
---@param fnames string[]
---@param funcbody table<string, string>
local func_picker = function(fnames, funcbody)
  pickers.new({}, {
    layout_config = {
      horizontal = {
        preview_cutoff = 0,
        preview_width = 0.67
      }
    },
    prompt_title = "Function",
    finder = finders.new_table {
      results = fnames,
    },
    results_title = "Functions",
    previewer = previewers.new_buffer_previewer {
      title = "Function Body",
      define_preview = function(self, entry, _)
        local func_str = funcbody[entry.value]
        local func_table = { "" }
        for line in func_str:gmatch("[^\r\n]+") do
          table.insert(func_table, line)
        end
        vim.api.nvim_set_option_value(
          'filetype',
          'nim',
          {
            buf = self.state.bufnr
          }
        )
        vim.api.nvim_buf_set_lines(
          self.state.bufnr,
          0,
          -1,
          false,
          func_table
        )
      end
    },
    sorter = conf.generic_sorter(),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        test_function(selection.value)
      end)
      return true
    end,
  }):find()
end

-- find all function names, create a picker, and execute tests
local function nimFuncTester()
  ---@type string[]
  local fnames = {}
  ---@type table<string, string>
  local funcbody = {}
  ---@type integer
  local bufnr = vim.api.nvim_get_current_buf()
  ---@type TSNode
  local root = get_root(bufnr)
  for _, node in q:iter_captures(root, bufnr, 0, -1) do
    if node:type() == "interpreted_string_literal" then
      ---@type string
      local func_name = vim.treesitter.get_node_text(node, bufnr, {})
      ---@type TSNode?
      local parent = node:parent()
      if parent then
        local ptext = vim.treesitter.get_node_text(parent, bufnr, {})
        funcbody[func_name] = ptext
        table.insert(fnames, func_name)
      end
    end
  end
  if #fnames == 0 then
    vim.api.nvim_notify("No Functions Found", vim.log.levels.ERROR, {})
    return
  end
  func_picker(fnames, funcbody)
end

-- set keymapping
vim.keymap.set('n', '<Space>tf', nimFuncTester, opts)
