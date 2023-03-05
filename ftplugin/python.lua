vim.opt_local.listchars = ({ eol = '↵', multispace = "--->" })

local help = require("cFuncs.helpers")

local keymap = vim.keymap.set

local function blackFormat()
    help.filecmd("black -q")
end

keymap('n', '<Space>tf', FileUnnittest, {desc = "unittest file"})
keymap('n', '<Space>f', blackFormat, {desc = "black format"})
