-- get the plugins
require('plugins')

-- My Plugins --
-- TermBro
require('termbro')
-- Zig
vim.g.zig_settings = {
  test = '<space>tf',
  build = '<space>bf',
  save = { format = true, build = false },
}
-- Rails
vim.g.roron_autos = true
-- Go
require('go')
----------------

-- Salesforce
require('force.force')

-- get the autocommands
require('autocmd')

-- get the lsp Setup
require('lspconf')

-- global configurations --
vim.cmd [[set nohlsearch]]
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.list = true
-- set default
vim.opt.listchars:append({ eol = '↵', lead = "." })
vim.o.swapfile = false
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- treesitter based tags
-- folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 32
vim.cmd[[set nofoldenable]]

-- sniprun
require 'sniprun'.setup({})

-- Org
require'orgmode'.setup({
  org_indent_mode = "indent"
})
require('orgmode').setup_ts_grammar()

-- slime
vim.g.slime_target = "neovim"

-- auto pairs
require('nvim-autopairs').setup()

-- nvim tree
require('nvim-tree').setup()

-- nvim surround
require('nvim-surround').setup()

-- comments
vim.g.NERDSpaceDelims = 1

-- Telescope
local telescope_theme = "ivy"
require('telescope').setup({
  -- set theme of used pickers
  pickers = {
    find_files = {
      theme = telescope_theme,
    },
    buffers = {
      theme = telescope_theme,
    },
    help_tags = {
      theme = telescope_theme,
    },
    keymaps = {
      theme = telescope_theme,
    }
  }
})
require('telescope').load_extension('fzf')

-- Code Window
local codewindow = require('codewindow')
codewindow.setup()
codewindow.apply_default_keybinds()

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
keymap({ 'n', 'i' }, '<leader>t', '<cmd> OpenTerm<CR>', { noremap = true, silent = true })
keymap('t', '<leader>t', '<cmd> OpenTerm<CR>]', { noremap = true, silent = true })
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
local gruv = require('gruvbox')
gruv.setup({
  transparent_mode = true,
})
vim.cmd [[colorscheme gruvbox]]

--> allowing mouse support
vim.o.mouse = 'nv' --> normal / visual

---- Os Specific
-- LateX
-- if vim.loop.os_uname().sysname == 'Darwin' then
-- vim.g.vimtex_view_method = 'skim'
-- else
-- vim.g.vimtex_view_method = 'zathura'
-- end

---- Functions
function SaveClipper()
  vim.cmd(":%s/ $//")
  vim.cmd(":w")
end

---- Send Buff
function SendBuf()
  local first = 1
  local last = vim.api.nvim_buf_line_count(0)
  -- vim.cmd(first .. "," .. last .. "SlimeSend")
  require 'sniprun.api'.run_range(first, last)
end

function LoadJL()
  -- get buffer name
  local buf = vim.api.nvim_buf_get_name(0)
  -- make and move to window
  vim.cmd("wincmd n")
  vim.cmd("wincmd J")
  -- load file into terminal
  local command = "julia -i " .. buf
  vim.fn.termopen(command)
end
