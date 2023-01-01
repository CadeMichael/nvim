-- autocmd's

-- http
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "apexcode",
    },
    command = [[nnoremap <silent><buffer> <Space>ar :lua RunAnonymousFile()<CR>]]
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
    set listchars=eol:↵,multispace:\ \|
    ]],
  }
)

-- go
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "go",
    },
    callback = function()
      vim.o.expandtab = false
      vim.o.tabstop = 4
      vim.o.shiftwidth = 4
      vim.o.softtabstop = 4
    end,
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

-- Julia
vim.api.nvim_create_autocmd(
  "filetype",
  {
    pattern = {
      "julia",
    },
    command = [[
    nnoremap <silent><buffer> <space>rf :lua LoadJL()<cr>
    ]],
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
    nnoremap <silent><buffer> <space>rf :LoadNode J<CR>
    nnoremap <silent><buffer> <space>rc :RunNpm<CR>
    ]],
  }
)

-- Python Django
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "python",
    },
    command = [[
    nnoremap <silent><buffer> <Space>rc :ManagePy J<CR>
    nnoremap <silent><buffer> <Space>rf :lua LoadPy('J')<CR>
    set listchars=eol:↵,multispace:---+
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
