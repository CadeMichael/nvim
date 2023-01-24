local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<space>rr", OpenMlRepl, opts)
keymap("n", "<space>ri", GetMlId, opts)
