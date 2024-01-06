local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local test_cmd = "go test -run "

local q = vim.treesitter.query.parse("go", [[
    (function_declaration name: (identifier) @name)
    ]])

local get_root = function(bufnr)
    local parser = vim.treesitter.get_parser(bufnr, "go", {})
    local tree = parser:parse()[1]
    return tree:root()
end

local function handle_data(data)
    local output = {}
    for _, v in ipairs(data) do
        table.insert(output, v)
    end
    local msg = ''
    if output then
        for _, v in ipairs(data) do
            msg = msg .. v .. "\n"
        end
    end
    if #msg > 1 then
        vim.api.nvim_notify(msg, vim.log.levels.INFO, {})
    end
end

local function test_function(fname, bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local command = test_cmd .. fname .. " " .. bufname
    vim.fn.jobstart(command, {
        stderr_buffered = true,
        stdout_buffered = true,
        on_stderr = function(_, data)
            if #data > 1 then
                handle_data(data)
            end
        end,
        on_stdout = function(_, data)
            if #data > 1 then
                handle_data(data)
            end
        end,
    })
end

local func_picker = function(fnames, funcbody, bufnr)
    pickers.new({}, {
        layout_config = {
            horizontal = {
                preview_cutoff = 0,
                preview_width = 0.67
            }
        },
        prompt_title = "Test Functions",
        finder = finders.new_table {
            results = fnames
        },
        previewer = previewers.new_buffer_previewer {
            title = "My preview",
            define_preview = function(self, entry, _)
                local func_str = funcbody[entry.value]
                local func_table = { "" }
                for line in func_str:gmatch("[^\r\n]+") do
                    table.insert(func_table, line)
                end
                vim.api.nvim_set_option_value(
                    'filetype',
                    'go',
                    {
                        buf = self.state.bufnr
                    }
                )
                vim.api.nvim_buf_set_lines(
                    self.state.bufnr,
                    0,
                    -1,
                    false,
                    func_table
                )
            end
        },
        sorter = conf.generic_sorter(),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                test_function(selection.value, bufnr)
            end)
            return true
        end,
    }):find()
end

local function goFuncTester()
    local fnames = {}
    local funcbody = {}
    local bufnr = vim.api.nvim_get_current_buf()
    local root = get_root(bufnr)
    for _, node in q:iter_captures(root, bufnr, 0, -1) do
        local func_name = vim.treesitter.get_node_text(node, bufnr, {})
        local parent = node:parent()
        local ptext = vim.treesitter.get_node_text(parent, bufnr, {})
        funcbody[func_name] = ptext
        table.insert(fnames, func_name)
    end
    if #fnames == 0 then
        vim.api.nvim_notify("No Functions Found", vim.log.levels.ERROR, {})
        return
    end
    func_picker(fnames, funcbody, bufnr)
end


vim.keymap.set('n', '<Space>T', goFuncTester, {})
