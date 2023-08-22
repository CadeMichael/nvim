vim.opt_local.listchars = ({ eol = '↵' })

local help = require("funcs.helpers")

local keymap = vim.keymap.set

local function blackFormat()
    help.filecmd("black -q")
end

keymap('n', '<Space>tf', FileUnnittest, { desc = "unittest file" })
keymap('n', '<Space>bf', blackFormat, { desc = "black format" })
