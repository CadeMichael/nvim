local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<space>rr", OpenUtop, opts)
keymap("n", "<space>ri", GetUtopId, opts)
