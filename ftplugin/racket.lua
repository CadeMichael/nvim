local send_sexp = "<Esc>va(<Plug>SlimeRegionSend%"
local function racket_rep()
    vim.cmd [[wincmd n]]
    vim.cmd [[wincmd J]]
    vim.fn.termopen("racket", { cwd = vim.fn.getcwd() })
    vim.cmd [[echo &channel]]
end

local keymap = vim.keymap.set

keymap('n', '<Space>rr', racket_rep, { desc = "open racket repl" })
keymap({ 'n', 'i' }, '<C-c>s', send_sexp, { desc = "repl send sexp" })
