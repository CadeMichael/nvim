-- autocmd's
-- emmet
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "html",
      "css",
      "php",
      "vue",
    },
    command = "EmmetInstall",
  }
)
-- http 
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "http",
    },
    command = [[nnoremap <silent><buffer> <Space>r <Plug>RestNvim]]
  }
)
-- ruby load 
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "ruby",
    },
    command = [[nnoremap <silent><buffer> <Space>L :lua LoadIRB()<CR>]],
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
