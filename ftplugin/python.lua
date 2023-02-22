vim.opt_local.listchars = ({ eol = '↵', multispace = "--->" })

local help = require("cFuncs.helpers")

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local function blackFormat()
  help.filecmd("black")
end

keymap('n', '<Space>tf', FileUnnittest, opts)
keymap('n', '<Space>f', blackFormat)
