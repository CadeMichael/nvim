local flix_cmd = require("flix.commands").flix_cmd

local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()

keymap('n', '<Space>br', function() flix_cmd("run") end,
  { noremap = true, silent = true, buffer = bufnr, desc = "run flix project" })
keymap('n', '<Space>bt', function() flix_cmd("test") end,
  { noremap = true, silent = true, buffer = bufnr, desc = "run flix project" })
