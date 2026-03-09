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

-- Filetypes without line numbers or a color colorcolumn
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "markdown",
      "oil",
    },
    command = "setlocal nonumber norelativenumber colorcolumn=0",
  }
)
