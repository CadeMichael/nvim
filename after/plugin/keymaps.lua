--------------
-- keymappings
--------------

local keymap = vim.keymap.set

-- Telescope
local ts = require('telescope.builtin')
local opts = { noremap = true, silent = true }
keymap('n', '<Space>bs', ts.buffers, opts)
keymap('n', '<Space>.', ts.find_files, opts)
keymap('n', '<Space>pf', ts.git_files, opts)
keymap('n', '<Space>h', ts.help_tags, opts)
keymap('n', '<Space>m', ts.keymaps, opts)
-- custom project search function
keymap('n', '<Space>ps', function()
  ts.grep_string({ search = vim.fn.input("Grep > ") })
end)
-- comments
keymap({ 'v', 'n' }, '<Space>;', "<Plug>NERDCommenterToggle", opts)
-- Slime
keymap('n', '<Space>l', "<cmd>SlimeSendCurrentLine<CR>", opts)
-- Trouble
keymap('n', '<Space>tt', "<cmd> TroubleToggle<CR>", opts)
-- Cht.sh
keymap('n', '<Space>cs', CheatSheet, opts)
-- Compile
keymap('n', '<Space>cc', Compile, opts)
-- git
keymap('n', '<C-x>g', "<cmd> Neogit<CR>", opts)
keymap('n', '<Space>gp', '<cmd>Gitsigns preview_hunk<CR>', opts)
keymap('n', '<Space>gn', '<cmd>Gitsigns next_hunk<CR>', opts)
-- terminal
keymap({ 'n', 'i' }, '<C-c><C-z>', OpenTerm, opts)
keymap('t', '<C-c><C-z>', OpenTerm, opts)
-- prevent nvim from being suspended
keymap({ 'n', 'i' }, '<C-z>', '<Esc>', opts)

-- remaps
keymap('n', '<Space>n', vim.cmd.Ex)
keymap('n', '<Space>bk', ':bdelete!<CR>', opts)
keymap('n', 'Y', 'y$', opts)
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)
keymap('i', '.', '.<C-g>u', opts)
keymap('i', ',', ',<C-g>u', opts)
keymap('i', '[', '[<C-g>u', opts)
keymap('i', '(', '(<C-g>u', opts)
keymap('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('v', 'K', ":m '<-2<CR>gv=gv", opts)
keymap('n', '<c-d>', '<c-d>zz')
keymap('n', '<c-u>', '<c-u>zz')
