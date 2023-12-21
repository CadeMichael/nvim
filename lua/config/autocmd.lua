------------
-- autocmd's
------------

-- netrw
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
