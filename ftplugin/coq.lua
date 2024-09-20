local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

vim.g.coqtail_nomap = 1

local coqPrint = function ()
  local var = vim.fn.input("Print => ")
  vim.cmd("Coq Print " .. var)
end

local coqCheck = function ()
  local var = vim.fn.input("Check => ")
  vim.cmd("Coq Check " .. var)
end

keymap('n', '<Space>cn', '<cmd>CoqNext<CR>', opts)
keymap('n', '<Space>cq', '<cmd>CoqStop<CR>', opts)
keymap('n', '<Space>ci', '<cmd>CoqInterrupt<CR>', opts)
keymap('n', '<Space>cs', '<cmd>CoqStart<CR>', opts)
keymap('n', '<Space>cu', '<cmd>CoqUndo<CR>', opts)
keymap('n', '<Space>c.', '<cmd>CoqToLine<CR>', opts)
keymap('n', '<Space>cp', coqPrint, opts)
keymap('n', '<Space>cc', coqCheck, opts)
