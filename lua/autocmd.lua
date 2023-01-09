------------
-- autocmd's
------------

-- SaleForce
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "apexcode",
    },
    command = [[
    nnoremap <silent><buffer> <Space>ar :lua RunAnonymousFile()<CR>
    ]]
  }
)

-- emmet
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "css",
      "eruby",
      "html",
      "php",
      "svelte",
      "vue",
    },
    command = [[
    EmmetInstall
    setlocal listchars=eol:↵,multispace:\ \|
    ]],
  }
)

-- netrw
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "netrw",
    },
    callback = function ()
      vim.opt_local.colorcolumn = ''
    end
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

-- js & npm
vim.api.nvim_create_autocmd(
  "filetype",
  {
    pattern = {
      "javascript",
      "typescript",
      "typescriptreact",
      "javascriptreact",
    },
    command = [[
    nnoremap <silent><buffer> <space>rc :RunNpm<CR>
    ]],
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
