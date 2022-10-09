-- get the plugins
require('plugins')

-- get the autocommands
require('autocmd')

-- get the lsp Setup
require("lspconf")

-- global configurations --
vim.cmd("set rnu")
vim.cmd("set nohlsearch")
vim.o.swapfile = false
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- treesitter based tags
-- folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 32

-- slime
vim.g.slime_target = "neovim"

-- auto pairs
require('nvim-autopairs').setup()

-- nvim tree
require('nvim-tree').setup()

-- nvim surround
require('nvim-surround').setup()

-- Telescope
require('telescope').setup()
require('telescope').load_extension('fzf')

-- statusline
require('lualine').setup({})

-- which key
require('which-key').setup({
  window = {
    border = 'double'
  }
})

-- emmet vim
vim.g.user_emmet_install_global = 0

-- keymappings --
local keymap = vim.keymap.set

-- nvimtree
keymap('n', '<Space>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Telescope
keymap('n', '<Space>.', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
keymap('n', '<Space>bs', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
keymap('n', '<Space>h', '<cmd>Telescope help_tags<cr>', { noremap = true, silent = true })
keymap('n', '<Space>m', '<cmd>Telescope keymaps<cr>', { noremap = true, silent = true })
-- comments
keymap({ 'v', 'n' }, '<Space>;', "<Plug>NERDCommenterToggle", { noremap = true, silent = true })
vim.g.NERDSpaceDelims = 1
-- clip ending white space and save
keymap('n', '<Space>s', ":lua SaveClipper()<CR>", { noremap = true, silent = true })
-- slime
keymap('v', '<Space>r', "<Plug>SlimeRegionSend", { noremap = true, silent = true })
keymap('n', '<Space>l', "V<Plug>SlimeRegionSend$", { noremap = true, silent = true })
keymap('n', '<C-x><C-e>', "va(<Plug>SlimeRegionSend%", { noremap = true, silent = true })
-- Trouble
keymap('n', '<Space>tt', ":TroubleToggle<CR>", { noremap = true, silent = true })
-- Compile
keymap('n', '<Space>cc', ":CompileCurrent<CR>", { noremap = true, silent = true })
-- Neogit
keymap('n', '<C-x>g', ":Neogit<CR>", { noremap = true, silent = true })
-- terminal
keymap({ 'n', 'i' }, '<C-c><C-z>', '<Esc>:lua OpenTerm() <CR>', { noremap = true, silent = true })
keymap('t', '<C-c><C-z>', '<C-\\><C-N><C-w>w]', { noremap = true, silent = true })
-- prevent nvim from being suspended
keymap({ 'n', 'i' }, '<C-z>', '<Esc>', { noremap = true, silent = true })

-- remaps
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

--> themeing
vim.g.startify_custom_header = {} -- no header

-- colorscheme
vim.opt.termguicolors = true
vim.cmd [[colorscheme oxocarbon]]

--> allowing mouse support
vim.o.mouse = 'nv' --> normal / visual

-- Neovide
vim.cmd([[set guifont=Hack\ Nerd\ Font:h16]])
vim.g.neovide_transparency = 0.85
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

---- Os Specific
-- LateX
if vim.loop.os_uname().sysname == 'Darwin' then
  vim.g.vimtex_view_method = 'skim'
else
  vim.g.vimtex_view_method = 'zathura'
end

---- Plugin Functions
function SaveClipper()
  vim.cmd(":%s/ $//")
  vim.cmd(":w")
end

-- determine if there is a terminal buf
function IsTerm()
  -- get all buffers
  local bufs = vim.api.nvim_list_bufs()
  -- iterate through bufs
  for _, b in ipairs(bufs) do
    -- get name
    local bName = vim.api.nvim_buf_get_name(b)
    -- check for term
    if string.find(bName, "term://") ~= nil then
      -- switch window and return
      vim.cmd [[:wincmd w]]
      return true
    end
  end
  -- no term buffers
  return false
end

-- open terminal in new window
function OpenTerm()
  -- get current buffer & name
  local buf = vim.api.nvim_get_current_buf();
  local bufName = vim.api.nvim_buf_get_name(buf);
  -- check if you're in a term
  local type = vim.fn.split(bufName, ":")[1]
  if type == "term" then
    -- don't open new term, switch windows
    vim.cmd [[:wincmd w]]
    return
  -- find a term or make one and switch
  elseif IsTerm() ~= true then
    vim.cmd("bel split")
    vim.cmd("terminal")
  end
end

-- open ruby repl with current file loaded
function LoadIRB(pos)
  -- get buffer name
  local buf = vim.api.nvim_buf_get_name(0)
  -- make and move to window
  vim.cmd(":wincmd n")
  vim.cmd(":wincmd " .. pos)
  -- load file into terminal
  local command = "irb -r" .. buf
  vim.fn.termopen(command)
end
