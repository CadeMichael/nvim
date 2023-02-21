vim.opt_local.listchars = ({ eol = '↵', multispace = "--->" })

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '<Space>tf', FileUnnittest, opts)
