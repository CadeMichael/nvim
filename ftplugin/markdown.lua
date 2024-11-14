local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

-- Keybindings
keymap({'n', 'i'}, '<C-c><C-c>', '<cmd>MdEval<CR>', opts)
