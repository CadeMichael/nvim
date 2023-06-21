------------
-- autocmd's
------------

-- emmet
vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = {
            "css",
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
