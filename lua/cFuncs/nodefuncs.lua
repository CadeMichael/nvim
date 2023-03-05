-- run npm commands
function RunNpm()
    -- get root dir ie with package.json
    local root = vim.lsp.buf.list_workspace_folders()[1] or vim.fn.getcwd()
    -- build full command including dir change
    local go_root = "cd " .. root .. " && "
    local command = "npm " .. vim.fn.input("npm => ", "")
    -- create blank window
    vim.cmd "wincmd n"
    vim.cmd "wincmd J"
    -- run npm command
    vim.fn.termopen(go_root .. command)
end
