-- autocmd's

-- emmet
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "html",
      "css",
      "php",
      "svelte",
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

-- JS load 
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "javascript",
    },
    command = [[
    nnoremap <silent><buffer> <Space>Lb :lua LoadNode('J')<CR>
    nnoremap <silent><buffer> <Space>Ls :lua LoadNode('L')<CR>
    ]],
  }
)

-- ruby load 
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "ruby",
    },
    command = [[
    nnoremap <silent><buffer> <Space>Lb :lua LoadIRB('J')<CR>
    nnoremap <silent><buffer> <Space>Ls :lua LoadIRB('L')<CR>
    nnoremap <silent><buffer> <Space>Lr :lua RailsSandbox('J', true)<CR>
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
