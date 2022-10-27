-- autocmd's

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

-- JS & Npm
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {
      "javascript",
      "typescript",
      "typescriptreact",
      "javascriptreact",
    },
    command = [[
    nnoremap <silent><buffer> <Space>Lb :LoadNode J<CR>
    nnoremap <silent><buffer> <Space>Ls :LoadNode L<CR>
    nnoremap <silent><buffer> <Space>rc :RunNpm <CR>
    ]],
  }
)

-- ruby 
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
    nnoremap <silent><buffer> <Space>rt :RailsTestFile<CR>
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
