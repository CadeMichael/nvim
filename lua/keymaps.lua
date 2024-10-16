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
-- buffer navigation
vim.keymap.set('n', '[b', '<cmd>bprevious<CR>', opts)
vim.keymap.set('n', ']b', '<cmd>bnext<CR>', opts)
-- remaps
map('n', '<Space>bk', ':bdelete!<CR>', opts)
map('n', '<Space>x', ':x<CR>', opts)
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
local cl = 0
vim.keymap.set('n', '<Space>C', function()
    cl = cl == 0 and 1 or 0
    vim.cmd("set conceallevel=" .. cl)
  end,
  { desc = "toggle conceallevel" }
)
-- Floaterm Fzf
-- Termcodes for Floaterm
local term_handler = vim.api.nvim_replace_termcodes(
  '<C-\\><C-n>GA',
  true,
  true,
  true
)
-- open a term with command from history
local function floatFzf()
  vim.g.floaterm_autoclose = 0
  local cmd = "source ~/.zshrc ; eval $(cat ~/.zsh_history | cut -d';' -f2- | tac | awk '!seen[$0]++' | fzf)"
  vim.cmd("FloatermNew " .. cmd)
  vim.api.nvim_feedkeys(term_handler, 'n', true)
  vim.g.floaterm_autoclose = 1
end

map('n', '<Space>F', floatFzf, opts)
