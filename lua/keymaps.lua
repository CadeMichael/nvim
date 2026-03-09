-- globals
function Map(mode, lhs, rhs, opts, desc)
  opts = opts or {}
  if desc then
    opts["desc"] = desc
  end
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

Opts = { noremap = true, silent = true }

function AddDesc(opts, desc)
  return vim.tbl_extend('force', opts, { desc = desc })
end

-- prevent nvim suspending
Map({ 'n', 'i' }, '<C-z>', '<Esc>', Opts)
-- buffer navigation
vim.keymap.set('n', '[b', '<cmd>bprevious<CR>', Opts)
vim.keymap.set('n', ']b', '<cmd>bnext<CR>', Opts)
-- remaps
Map('n', '<Space>bk', ':bdelete!<CR>', Opts)
Map('n', '<Space>x', ':x<CR>', Opts)
Map('n', 'U', '<C-r>', Opts)
Map('n', 'Y', 'y$', Opts)
Map('n', 'n', 'nzzzv', Opts)
Map('n', 'N', 'Nzzzv', Opts)
Map('i', '.', '.<C-g>u', Opts)
Map('i', ',', ',<C-g>u', Opts)
Map('i', '[', '[<C-g>u', Opts)
Map('i', '(', '(<C-g>u', Opts)
Map('v', 'J', ":m '>+1<CR>gv=gv", Opts)
Map('v', 'K', ":m '<-2<CR>gv=gv", Opts)
Map('n', '<C-d>', '<C-d>zz')
Map('n', '<C-u>', '<C-u>zz')
-- terminal mode window commands
Map('n', '<space><space>', function()
  local dir = vim.fn.expand('%:p:h')
  vim.system({ "tmux", "split-window", "-c", dir })
end, Opts)
Map('t', '<C-w>', '<C-\\><C-n><C-w>', Opts)
-- windows
vim.keymap.set({ 'n', 'i' }, '<A-=>', ':wincmd = <CR>', Opts)
vim.keymap.set({ 'n', 'i' }, '<A-,>', ':wincmd < <CR>', Opts)
vim.keymap.set({ 'n', 'i' }, '<A-.>', ':wincmd > <CR>', Opts)
-- text wrapping
local wrap = true
vim.keymap.set(
  'n',
  '<space>w',
  function()
    wrap = not wrap
    vim.o.wrap = wrap
  end,
  Opts)
-- random
vim.keymap.set('n', '<space>K', ':!cal<CR>', Opts)
