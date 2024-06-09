--------------
-- keymappings
--------------
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end
local opts = { noremap = true, silent = true }

-- prevent nvim suspending
map({ 'n', 'i' }, '<C-z>', '<Esc>', opts)
-- remaps
map('n', '<Space>bk', ':bdelete!<CR>', opts)
map('n', 'U', '<C-r>', opts)
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
-- Line Wrapping
local wrap = true
map('n', '<Space>W', function()
    wrap = not wrap
    vim.o.wrap = wrap
  end,
  { desc = "toggle line wrapping" }
)
-- Conceal Level
local cl = 1
vim.keymap.set('n', '<Space>C', function()
    cl = cl == 0 and 1 or 0
    vim.cmd("set conceallevel=" .. cl)
  end,
  { desc = "toggle conceallevel" }
)
