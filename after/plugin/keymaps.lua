--------------
-- keymappings
--------------

local keymap = vim.keymap.set

-- nvimtree
-- keymap('n', '<Space>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Telescope
local ts = require('telescope.builtin')
keymap('n', '<Space>bs', ts.buffers, { noremap = true, silent = true })
keymap('n', '<Space>.', ts.find_files, { noremap = true, silent = true })
keymap('n', '<Space>g.', ts.git_files, { noremap = true, silent = true })
keymap('n', '<Space>h', ts.help_tags, { noremap = true, silent = true })
keymap('n', '<Space>m', ts.keymaps, { noremap = true, silent = true })
-- custom project search function
keymap('n', '<Space>ps', function ()
  ts.grep_string({ search = vim.fn.input("Grep > ")})
end)
-- comments
keymap({ 'v', 'n' }, '<Space>;', "<Plug>NERDCommenterToggle", { noremap = true, silent = true })
-- clip ending white space and save
keymap('v', '<Space>r', "<Plug>SnipRun", { noremap = true, silent = true })
keymap('n', '<Space>l', "<Plug>SnipRun", { noremap = true, silent = true })
keymap('n', '<Space>sr', "<Plug>SnipReset", { silent = true })
keymap('n', '<Space>sc', "<Plug>SnipReplMemoryClean", { silent = true })
keymap('n', '<Space>sq', "<Plug>SnipClose", { silent = true })
keymap('n', '<C-c><C-b>', ":lua SendBuf()<CR>", { noremap = true, silent = true })
-- Trouble
keymap('n', '<Space>tt', "<cmd> TroubleToggle<CR>", { noremap = true, silent = true })
-- Cht.sh
keymap('n', '<Space>cs', "<cmd> CheatSheet<CR>", { noremap = true, silent = true })
-- Compile
keymap('n', '<Space>cc', "<cmd> CompileCurrent<CR>", { noremap = true, silent = true })
-- Neogit
keymap('n', '<C-x>g', "<cmd> Neogit<CR>", { noremap = true, silent = true })
-- terminal
keymap({ 'n', 'i' }, '<leader>t', ':lua OpenTerm()<CR>', { noremap = true, silent = true })
keymap('t', '<leader>t', '<cmd> OpenTerm<CR>', { noremap = true, silent = true })
-- prevent nvim from being suspended
keymap({ 'n', 'i' }, '<C-z>', '<Esc>', { noremap = true, silent = true })

-- remaps
keymap('n', '<leader>d', vim.cmd.Ex)
keymap('n', '<Space>bk', ':bdelete!<CR>', { noremap = true, silent = true })
keymap('n', 'Y', 'y$', { noremap = true, silent = true })
keymap('n', 'n', 'nzzzv', { noremap = true, silent = true })
keymap('n', 'N', 'Nzzzv', { noremap = true, silent = true })
keymap('i', '.', '.<C-g>u', { noremap = true, silent = true })
keymap('i', ',', ',<C-g>u', { noremap = true, silent = true })
keymap('i', '[', '[<C-g>u', { noremap = true, silent = true })
keymap('i', '(', '(<C-g>u', { noremap = true, silent = true })
keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
keymap('n', '<c-d>', '<c-d>zz')
keymap('n', '<c-u>', '<c-u>zz')
