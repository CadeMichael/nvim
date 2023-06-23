require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")

-- Auto open and close
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- C++ / Rust adapter
dap.adapters.lldb = {
    type = 'executable',
    command = '/etc/profiles/per-user/cadel/bin/lldb-vscode',
    name = 'lldb'
}

-- C++
-- need to compile with '-g' flag
dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ',
                vim.fn.getcwd() .. '/',
                'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}

-- Rust
-- with rust-tools simply hover on 'main' function
dap.configurations.rust = dap.configurations.cpp

-- Keymaps
local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end
map('n', '<F5>', function() dap.continue() end, { desc = 'dap continue' })
map('n', '<F10>', function() dap.step_over() end, { desc = 'dap step over' })
map('n', '<F11>', function() dap.step_into() end, { desc = 'dap step into' })
map('n', '<F12>', function() dap.step_out() end, { desc = 'dap step out' })
map('n', '<Leader>b', function() dap.toggle_breakpoint() end, { desc = 'dap toggle breakpoint' })
map('n', '<Leader>B', function() dap.set_breakpoint() end, { desc = 'dap set breakpoint' })
map('n', '<Leader>lp',
    function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    { desc = 'breakpoint log point message' })
map('n', '<Leader>dr', function() dap.repl.open() end, { desc = 'dap repl open' })
map('n', '<Leader>dl', function() dap.run_last() end, { desc = 'dap run last' })
map({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end, { desc = 'dap ui widgets hover' })
map({ 'n', 'v' }, '<Leader>dp', function()
    dap.ui.widgets.preview()
end, { desc = 'dap ui widgets preview' })
map('n', '<Leader>df', function()
    local widgets = dap.ui.widgets
    widgets.centered_float(widgets.frames)
end, { desc = 'dap ui widgets center float frames' })
map('n', '<Leader>ds', function()
    local widgets = dap.ui.widgets
    widgets.centered_float(widgets.scopes)
end, { desc = 'dap ui widgets float scopes' })
