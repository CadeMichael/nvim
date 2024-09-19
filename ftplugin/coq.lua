local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

keymap('n', '<Space>cn', '<cmd>CoqNext<CR>', opts)
keymap('n', '<Space>cq', '<cmd>CoqStop<CR>', opts)
keymap('n', '<Space>cs', '<cmd>CoqStart<CR>', opts)
keymap('n', '<Space>cu', '<cmd>CoqUndo<CR>', opts)
keymap('n', '<Space>c.', '<cmd>CoqToLine<CR>', opts)
