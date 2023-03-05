vim.opt_local.expandtab = false
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

local keymap = vim.keymap.set
keymap('n', '<Space>gr', GoRunFile, { desc = "go run file" })
keymap('n', '<Space>bp', GoBuildProj, { desc = "go build" })
