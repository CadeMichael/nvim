local M = {}

local selected_files = {}
local files = {}
local cur_dir
local current_line = 1
local buf, win
local help_menu = "| j: ↑ | k: ↓ | l: open dir | h: parent dir | <CR>: sel |"
local offset = 3

-- create a floating window
local function create_window()
  buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.85)
  local height = math.floor(vim.o.lines * 0.85)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded"
  })
end

-- render the file list with [ ] or [x]
local function render()
  local lines = { "[" .. cur_dir .. "]", help_menu, }
  for _, file in ipairs(files) do
    local cur = ""
    local mark = selected_files[file] and "[x]" or "[ ]"
    file = vim.fn.isdirectory(file) == 1 and file .. "/" or file
    table.insert(lines, cur .. mark .. " " .. file)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_win_set_cursor(win, { current_line, 0 })
end

-- toggle selection state
local function toggle()
  -- first 3 lines are headers
  if current_line < offset then
    return
  end
  local file = files[current_line - 2]
  selected_files[file] = not selected_files[file]
  render()
end

-- enter parent directory
local function enter_parent()
  local dir_path = vim.fn.split(cur_dir, "/")
  cur_dir = ""
  for i, d in ipairs(dir_path) do
    if i ~= #dir_path then
      cur_dir = cur_dir .. "/" .. d
    end
  end
  files = vim.fn.readdir(cur_dir)
  current_line = 1
  render()
end

-- enter subdir and rerender
local function enter_subdir()
  if current_line < offset then return end
  local file = files[current_line - 2]
  local full_path = cur_dir .. "/" .. file
  if vim.fn.isdirectory(full_path) == 1 then
    cur_dir = full_path
    files = vim.fn.readdir(cur_dir)
    current_line = 1
    render()
  end
end

-- move cursor and keep track of line
local function move_cursor(delta)
  local num_lines = #files + 2
  current_line = math.max(1, math.min(num_lines, current_line + delta))
  vim.api.nvim_win_set_cursor(win, { current_line, 0 })
end

-- quit the window
local function quit()
  vim.api.nvim_win_close(win, true)
end

function M.browse(dir)
  cur_dir = dir
  files = vim.fn.readdir(cur_dir)
  selected_files = {}
  current_line = 1
  create_window()
  render()

  -- key mappings
  local opts = { noremap = true, silent = true, nowait = true }
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "",
    vim.tbl_extend("force", opts, { callback = quit }))
  vim.api.nvim_buf_set_keymap(buf, "n", "j", "",
    vim.tbl_extend("force", opts, { callback = function() move_cursor(1) end }))
  vim.api.nvim_buf_set_keymap(buf, "n", "k", "",
    vim.tbl_extend("force", opts, { callback = function() move_cursor(-1) end }))
  vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "",
    vim.tbl_extend("force", opts, { callback = toggle }))
  vim.api.nvim_buf_set_keymap(buf, "n", "l", "",
    vim.tbl_extend("force", opts, { callback = enter_subdir }))
  vim.api.nvim_buf_set_keymap(buf, "n", "h", "",
    vim.tbl_extend("force", opts, { callback = enter_parent }))
end

return M
