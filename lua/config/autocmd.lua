------------
-- autocmd's
------------

-- linting
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- oil
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "oil",
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
