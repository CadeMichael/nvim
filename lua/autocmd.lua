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
    nnoremap <silent><buffer> <Space>Lb :LoadNode J<CR>
    nnoremap <silent><buffer> <Space>Ls :LoadNode L<CR>
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
    nnoremap <silent><buffer> <Space>Lb :LoadIRB J<CR>
    nnoremap <silent><buffer> <Space>Ls :LoadIRB L<CR>
    nnoremap <silent><buffer> <Space>rc :RailsCommand J true console --sandbox<CR>
    nnoremap <silent><buffer> <Space>rr :RailsCommand J true server<CR>
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
    nnoremap <silent><buffer> <Space>Lb :ManagePy J<CR>
    nnoremap <silent><buffer> <Space>Ls :ManagePy L<CR>
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
