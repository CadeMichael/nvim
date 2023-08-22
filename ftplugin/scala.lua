local keymap = vim.keymap.set

local function scala_send_line()
    local l = vim.api.nvim_get_current_line()
    OpenTerm()
    vim.fn.feedkeys("A" .. l)
end

local function scala_send_region()
    vim.api.nvim_command("normal! y")
    OpenTerm()
    vim.defer_fn(function()
        vim.api.nvim_exec2("normal! p A", {})
    end, 10)
end

keymap('n', '<Space>sl', scala_send_line, { desc = "scala send line" })
keymap('v', '<Space>sr', scala_send_region, { desc = "scala send region" })
