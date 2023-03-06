local map = vim.keymap.set
local opts = { silent = true }

map('n', '<C-c>ng', ":Neorg keybind all core.looking-glass.magnify-code-block<CR>", opts)
map('n', '<C-c>np', ":Neorg presenter start<CR>", opts)
