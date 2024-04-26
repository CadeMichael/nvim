local keymap = vim.keymap.set

local function blackFormat()
  local file = vim.api.nvim_buf_get_name(0)
  vim.cmd("!black -q " .. file)
end

keymap('n', '<Space>tf', FileUnnittest, { desc = "unittest file" })
keymap('n', '<Space>bf', blackFormat, { desc = "black format" })
