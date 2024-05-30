---------------
-- autocmd's --
---------------

-- No colorcolumn ft
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "Trouble",
    },
    callback = function()
      vim.opt_local.colorcolumn = ''
    end
  }
)

-- term line num
vim.api.nvim_create_autocmd(
  "TermOpen",
  {
    pattern = "*",
    command = "setlocal nonumber norelativenumber nocursorline",
  }
)
