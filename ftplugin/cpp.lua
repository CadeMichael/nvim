function Bcp()
    local fname = vim.api.nvim_buf_get_name(0)
    local split_name = vim.fn.split(fname, "/")
    local name = split_name[#split_name]
    print(name)
    name = string.gsub(name, ".cc", "")
    vim.cmd("!g++ -Wall " .. fname .. " -o " .. name)
end

function Rcp()
    local fname = vim.api.nvim_buf_get_name(0)
    local name = string.sub(fname, 1, -4)
    vim.cmd("wincmd n")
    vim.cmd("wincmd J")
    vim.fn.termopen(name)
end

local keymap = vim.keymap.set
keymap('n', '<Space>bf', Bcp, { desc = "build file" })
keymap('n', '<Space>rf', Rcp, { desc = "run file" })

vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
