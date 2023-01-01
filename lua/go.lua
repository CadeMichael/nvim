function GoRunFile()
  local file = vim.api.nvim_buf_get_name(0)
  vim.cmd [[wincmd n]]
  vim.cmd [[wincmd J]]
  local command = "go run " .. file
  vim.fn.termopen(command)
end

-- keymappings --
local keymap = vim.keymap.set

keymap('n', '<Space>gr', ':lua GoRunFile()<CR>', { silent = true })
