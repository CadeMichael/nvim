-- autocmd's
-- emmet
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = { "html", "css" },
    command = "EmmetInstall",
  }
)
-- term line num
vim.api.nvim_create_autocmd(
  "TermOpen",
  {
    pattern = "*",
    command = "setlocal nonumber norelativenumber",
  }
)
