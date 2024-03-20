--------------
-- keymappings
--------------
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- imports
local oil = require('oil')
local tsb = require('telescope.builtin')
local ts = require('telescope')
local tst = require 'telescope.themes'

local opts = { noremap = true, silent = true }

local function get_opts(desc)
  return { desc = desc, noremap = true, silent = true }
end

map('n', '<Space>bs', tsb.buffers, { desc = "ts buf" })
map('n', '<Space>.', tsb.find_files, { desc = "ts find files" })
map('n', '<Space>pf', tsb.git_files, { desc = "ts git files" })
map('n', '<Space>h', tsb.help_tags, { desc = "ts help" })
map('n', '<Space>m', tsb.keymaps, { desc = "ts maps" })
-- custom project search function
map('n', '<Space>ps', function()
    tsb.grep_string({ search = vim.fn.input("Grep > ") })
  end,
  { desc = "grep project" }
)
-- notes
map('n', '<Space><space>', '<cmd>Telekasten panel<CR>', { desc = 'telekasten panel' })
map('n', '<Space>rf', '<cmd>Telekasten find_notes<CR>', { desc = 'telekasten find notes' })
-- comments
map({ 'v', 'n' }, '<Space>;', "<Plug>NERDCommenterToggle", opts)
-- Trouble / linting
map('n', '<Space>tt', "<cmd> TroubleToggle<CR>", opts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float,
    get_opts("diagnostic open float"))
  vim.keymap.set('n', '<space>E', function()
    tsb.diagnostics(tst.get_dropdown({}))
  end, get_opts("telescope diagnostics"))
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- git
map('n', '<Space>gp', '<cmd>Gitsigns preview_hunk<CR>', opts)
map('n', '<Space>gn', '<cmd>Gitsigns next_hunk<CR>', opts)
-- terminal
map('n', '<C-Space>', OpenTerm, { desc = "open term" })
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
map('n', '<c-d>', '<c-d>zz')
map('n', '<c-u>', '<c-u>zz')

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
