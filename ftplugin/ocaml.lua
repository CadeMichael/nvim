local keymap = vim.keymap.set

keymap("n", "<space>rr", OpenMlRepl, {desc = "open repl"})
keymap("n", "<space>ri", GetMlId, {desc = "get ml repl id"})
