local function loadPyBuff()
  local file = vim.api.nvim_buf_get_name(0)
  local interpreter = "python3"
  local dir = vim.fn.expand('%:p:h')
  vim.system({ "tmux", "split-window", "-c", dir, interpreter, "-i", file })
end

local bufnr = vim.api.nvim_get_current_buf()
local keymap = vim.keymap.set
keymap('n', '<Space>D', runPDB, { buffer = bufnr, desc = 'run pdb on current buffer' })
keymap('n', '<Space>bi', loadPyBuff, { buffer = bufnr, desc = 'open current buf in repl' })
