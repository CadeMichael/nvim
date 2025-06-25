vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.bo.commentstring = "// %s"

local function openFlixRepl(cmd)
  local root = vim.lsp.buf.list_workspace_folders()[1]
  if root == nil then
    return nil
  end

  vim.cmd("belowright split")
  local term_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, term_buf)

  vim.fn.jobstart({ "java", "-jar", "flix.jar", cmd}, {
    term = true,
    cwd = root,
  })
end


local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()

keymap('n', '<Space>br', function() openFlixRepl("run") end,
  { noremap = true, silent = true, buffer = bufnr, desc = "run flix project" })
