--------------
-- keymappings
--------------
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- imports
local oil = require 'oil'
local tsb = require 'telescope.builtin'

local opts = { noremap = true, silent = true }

local function get_opts(desc)
  return { desc = desc, noremap = true, silent = true }
end

-- telescope
map('n', '<Space>bs', tsb.buffers, { desc = "ts buf" })
map('n', '<Space>.', tsb.find_files, { desc = "ts find files" })
map('n', '<Space>pf', tsb.git_files, { desc = "ts git files" })
map('n', '<Space>h', tsb.help_tags, { desc = "ts help" })
map('n', '<Space>m', tsb.keymaps, { desc = "ts maps" })
map('n', '<Space>ps', tsb.live_grep, { desc = "grep project" })
map('n', '<Space>gs', tsb.git_status, { desc = 'git diff' })
-- notes
map('n', '<Space><Space>', '<cmd>Telekasten panel<CR>', { desc = 'telekasten panel' })
map('n', '<Space>rf', '<cmd>Telekasten find_notes<CR>', { desc = 'telekasten find notes' })
-- comments
map({ 'v', 'n' }, '<Space>;', "<Plug>NERDCommenterToggle", opts)
-- git
map('n', '<Space>gp', '<cmd>Gitsigns preview_hunk<CR>', opts)
map('n', '<Space>gn', '<cmd>Gitsigns next_hunk<CR>', opts)
-- terminal
map({ 'n', 'i' }, '<C-Space>', OpenTerm, { desc = "open term" })
map('t', '<C-Space>', OpenTerm, { desc = "open term" })
-- sniprun
map('v', '<space>R', '<Plug>SnipRun', { desc = "sniprun" })
map('n', '<space>R', '<Plug>SnipReset', { desc = "snipreset" })
-- prevent nvim from being suspended
map({ 'n', 'i' }, '<C-z>', '<Esc>', opts)

-- remaps
map('n', '<Space>n', oil.open_float, { desc = "open oil" })
map('n', '<Space>N', oil.open, { desc = "open oil" })
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
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- indent highlighting
map('n', '<Space>I', '<cmd>IBLToggle<CR>', { desc = "toggle indent highlighting" })
map('n', '<Space>S', '<cmd>IBLToggleScope<CR>', { desc = "toggle indent scope highlighting" })
-- Line Wrapping
local wrap = true
map('n', '<Space>W', function()
    wrap = not wrap
    vim.o.wrap = wrap
  end,
  { desc = "toggle line wrapping" }
)
