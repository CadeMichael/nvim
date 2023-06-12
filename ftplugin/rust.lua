-- vim.opt_local.listchars = ({ eol = '↵', multispace = "   >" })

local help = require('cFuncs.helpers')

local function rustFmt()
    help.filecmd("rustfmt")
end

vim.keymap.set('n', '<C-c>;', 'A;<Esc>')
vim.keymap.set('i', '<C-c>;', '<Esc>A;')
vim.keymap.set('n', '<C-c>r', '<cmd>RustRun<CR>')
vim.keymap.set('n', '<C-c>f', rustFmt, {desc = "rust format file"})
