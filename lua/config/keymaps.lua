--------------
-- keymappings
--------------
local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Telescope builtin
local tsb = require('telescope.builtin')
local opts = { noremap = true, silent = true }
map('n', '<Space>bs', tsb.buffers, { desc = "ts buf" })
map('n', '<Space>.', tsb.find_files, { desc = "ts find files" })
map('n', '<Space>pf', tsb.git_files, { desc = "ts git files" })
map('n', '<Space>h', tsb.help_tags, { desc = "ts help" })
map('n', '<Space>m', tsb.keymaps, { desc = "ts maps" })
-- custom project search function
map('n', '<Space>ps', function()
    tsb.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "grep project" })
-- TS Dap
local ts = require('telescope')
map('n', '<Space>tdc', ts.extensions.dap.commands, { desc = 'dap commands' })
map('n', '<Space>tdb', ts.extensions.dap.list_breakpoints, { desc = 'dap list bp' })
map('n', '<Space>tdv', ts.extensions.dap.variables, { desc = 'dap variables' })
map('n', '<Space>tdf', ts.extensions.dap.frames, { desc = 'dap frames' })
-- notes
map('n', '<Space><space>', '<cmd>Telekasten panel<CR>', { desc = 'telekasten panel' })
-- comments
map({ 'v', 'n' }, '<Space>;', "<Plug>NERDCommenterToggle", opts)
-- Slime
map('n', '<Space>l', "<cmd>SlimeSendCurrentLine<CR>", opts)
map('n', '<C-c><C-b>', SlimeBuf, { desc = "slime buf" })
-- Trouble
map('n', '<Space>tt', "<cmd> TroubleToggle<CR>", opts)
-- Cht.sh
map('n', '<Space>cs', CheatSheet, { desc = "cheat sheet" })
-- git
map('n', '<C-c>g', "<cmd> Neogit<CR>", opts)
map('n', '<Space>gp', '<cmd>Gitsigns preview_hunk<CR>', opts)
map('n', '<Space>gn', '<cmd>Gitsigns next_hunk<CR>', opts)
-- terminal
map({ 'n', 'i' }, '<C-c><C-z>', OpenTerm, { desc = "open term" })
map('t', '<C-c><C-z>', OpenTerm, { desc = "open term" })
-- prevent nvim from being suspended
map({ 'n', 'i' }, '<C-z>', '<Esc>', opts)

-- remaps
map('n', '<Space>n', vim.cmd.Ex, { desc = "open file manager" })
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
local wrap = true
map('n', '<Space>w', function()
    wrap = not wrap
    vim.o.wrap = wrap
end)
