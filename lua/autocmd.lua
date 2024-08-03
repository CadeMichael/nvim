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

-- Markdown no line number of color colorcolumn
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "Markdown", "Telekasten"
    },
    command = "setlocal nonumber norelativenumber colorcolumn=0",
  }
)

-- Term line numbers
vim.api.nvim_create_autocmd(
  "TermOpen",
  {
    pattern = "*",
    command = "setlocal nonumber norelativenumber nocursorline",
  }
)
