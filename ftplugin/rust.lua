local help = require('funcs.helpers')

local function rustFmt()
    help.filecmd("rustfmt")
end

vim.keymap.set('n', '<C-c>;', 'A;<Esc>')
vim.keymap.set('i', '<C-c>;', '<Esc>A;')
vim.keymap.set('n', '<C-c><C-c>', '<cmd>RustRun<CR>')
vim.keymap.set('n', '<Space>bf', rustFmt, {desc = "rust format file"})
