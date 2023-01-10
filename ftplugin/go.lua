vim.o.expandtab = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

local keymap = vim.keymap.set
keymap('n', '<Space>gr', GoRunFile, { silent = true })
keymap('n', '<Space>bp', GoBuildProj, { silent = true })
