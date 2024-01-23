local function cpp_build()
  local fname = vim.api.nvim_buf_get_name(0)
  local split_name = vim.fn.split(fname, "/")
  local name = split_name[#split_name]
  print(name)
  name = string.gsub(name, ".cpp", "")
  vim.cmd("!g++ -Wall " .. fname .. " -o " .. name)
end

local function cpp_run()
  local fname = vim.api.nvim_buf_get_name(0)
  local name = string.sub(fname, 1, -5)
  vim.cmd("wincmd n")
  vim.cmd("wincmd J")
  vim.fn.termopen(name)
end

local keymap = vim.keymap.set
keymap('n', '<Space>bf', cpp_build, { desc = "build file" })
keymap('n', '<Space>rf', cpp_run, { desc = "run file" })

-- prevent '#if defined' lack of highlighting
vim.api.nvim_set_hl(0, '@lsp.type.comment.cpp', {})

vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
