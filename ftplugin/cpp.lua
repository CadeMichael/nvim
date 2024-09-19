local function cpp_build()
  local fname = vim.api.nvim_buf_get_name(0)
  local split_name = vim.fn.split(fname, "/")
  local name = split_name[#split_name]
  print(name)
  name = string.gsub(name, ".cpp", "")
  name = string.gsub(name, ".cc", "")
  vim.cmd("!g++ -Wall " .. fname .. " -o " .. name)
end

local function cpp_run()
  local fname = vim.api.nvim_buf_get_name(0)
  local name = string.gsub(fname, ".cpp", "")
  name = string.gsub(fname, ".cc", "")
  vim.cmd.terminal(name)
end

local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()

local genOpts = function (s)
  local opts = { noremap = true, silent = true, buffer = bufnr, desc = s}
  return opts
end

keymap('n', '<Space>bb', cpp_build, genOpts("build file"))
keymap('n', '<Space>rb', cpp_run, genOpts("run file" ))

-- prevent '#if defined' lack of highlighting
vim.api.nvim_set_hl(0, '@lsp.type.comment.cpp', {})

vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
