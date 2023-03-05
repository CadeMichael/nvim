--------------
-- keymappings
--------------
local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

-- Telescope
local ts = require('telescope.builtin')
local opts = { noremap = true, silent = true }
map('n', '<Space>bs', ts.buffers, opts)
map('n', '<Space>.', ts.find_files, opts)
map('n', '<Space>pf', ts.git_files, opts)
map('n', '<Space>h', ts.help_tags, opts)
map('n', '<Space>m', ts.keymaps, opts)
-- custom project search function
map('n', '<Space>ps', function()
    ts.grep_string({ search = vim.fn.input("Grep > ") })
end)
-- comments
map({ 'v', 'n' }, '<Space>;', "<Plug>NERDCommenterToggle", opts)
-- Slime
map('n', '<Space>l', "<cmd>SlimeSendCurrentLine<CR>", opts)
map('n', '<C-c><C-b>', SlimeBuf, opts)
-- Trouble
map('n', '<Space>tt', "<cmd> TroubleToggle<CR>", opts)
-- Cht.sh
map('n', '<Space>cs', CheatSheet, opts)
-- Compile
map('n', '<Space>cc', Compile, opts)
-- git
map('n', '<C-c>g', "<cmd> Neogit<CR>", opts)
map('n', '<Space>gp', '<cmd>Gitsigns preview_hunk<CR>', opts)
map('n', '<Space>gn', '<cmd>Gitsigns next_hunk<CR>', opts)
-- terminal
map({ 'n', 'i' }, '<C-c><C-z>', OpenTerm, opts)
map('t', '<C-c><C-z>', OpenTerm, opts)
-- prevent nvim from being suspended
map({ 'n', 'i' }, '<C-z>', '<Esc>', opts)

-- remaps
map('n', '<Space>n', vim.cmd.Ex)
map('n', '<Space>bk', ':bdelete!<CR>', opts)
map('n', 'Y', 'y$', opts)
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('i', '.', '.<C-g>u', opts)
map('i', ',', ',<C-g>u', opts)
map('i', '[', '[<C-g>u', opts)
map('i', '(', '(<C-g>u', opts)
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)
map('n', '<c-d>', '<c-d>zz')
map('n', '<c-u>', '<c-u>zz')
