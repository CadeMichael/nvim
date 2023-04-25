local help = require("cFuncs.helpers")

function GoRunFile()
    local file = vim.api.nvim_buf_get_name(0)
    local command = "go run " .. file
    help.runCmd(command, vim.fn.getcwd(), help.printData)
end

function GoBuildProj()
    -- try lsp dirs
    local dir = vim.lsp.buf.list_workspace_folders()[1]
    -- prevent blank dir
    dir = dir or vim.fn.getcwd()
    local command = "go build"
    vim.api.nvim_notify("Building...", vim.log.levels.INFO, {})
    help.runCmd(vim.fn.split(command), dir, help.printData)
end
