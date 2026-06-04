-- defaults
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"
vim.opt.hlsearch = false

-- local values and functions
local scripts = vim.fn.stdpath('config') .. "/scripts/"

-- plugins
vim.pack.add({	
	-- theme
	'https://github.com/navarasu/onedark.nvim',
	-- treesitter
	{
		src = 'https://github.com/nvim-treesitter/nvim-treesitter',
		version = 'main',
	},
	-- file picking
	'https://github.com/dmtrKovalenko/fff.nvim',
	-- floating term
	'https://github.com/voldikss/vim-floaterm',
	-- surround
	{	-- ds[ | cs[ | ysiw) | ysiw( | ys$"
		src = 'https://github.com/kylechui/nvim-surround',
		version = vim.version.range('4.x'),
	},
	-- completion
	'https://github.com/saghen/blink.lib',
	'https://github.com/saghen/blink.cmp'
})

-- floaterm maps
vim.keymap.set(
	'n',
	'<space>gg',
	function()
		vim.cmd('FloatermNew --autoclose=1 --height=0.8 --width=0.8 lazygit')
	end,
	{ desc = 'lazygit floaterm' }
)

-- fuzzy file finding
-- setup
vim.g.fff = {
	prompt = '> ',
	lazy_sync = true,
	debug = { enabled = true, show_scores = true },
	keymaps = {
		close = '<C-c>',
	}
}

-- fff maps
vim.keymap.set('n', '<space>f', function() require('fff').find_files() end, { desc = 'FFFind files' })
vim.keymap.set('n', '<space>/', function() require('fff').live_grep() end, { desc = 'FFFind live_grep' })
vim.keymap.set('n', '<space>n', function() require('fff').find_files_in_dir("~/Documents/zkast/") end, { desc = 'FFFind notes' })

-- treesitter configuration
require('nvim-treesitter').setup {
  install_dir = vim.fn.stdpath('data') .. '/site'
}

local ts_langs = {
	'javascript',
	'json',
	'lua',
	'markdown',
	'markdown_inline',
	'odin',
	'python',
	'typescript',
	'zsh'
}

require('nvim-treesitter').install(ts_langs)

vim.api.nvim_create_autocmd('FileType', {
	pattern = ts_langs,
	callback = function()
		vim.treesitter.start()
		vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.wo[0][0].foldmethod = 'expr'
	end,
})

-- theme configuration
require('onedark').setup { style = 'darker', transparent = true }
require('onedark').load()

-- keymaps
vim.keymap.set('n', '<space>;', 'gcc', {remap = true})
vim.keymap.set('v', '<space>;', 'gc', {remap = true})
vim.keymap.set('n', '<space>r', 'zR', {remap = true})
vim.keymap.set('n', '<space>m', 'zM', {remap = true})
vim.keymap.set('n', '<space><space>', function()
	local dir = vim.fn.expand('%:p:h')
	vim.system({ "tmux", "split-window", "-c", dir })
end, {remap = true, silent = true})
vim.keymap.set('n', '<space>.', '<cmd>Ex %:p:h<CR>')
vim.keymap.set(
	'n',
	'<space>gl',
	function()
		log_helper = scripts .. "log-helper"
		cmd = 'FloatermNew --autoclose=0 --height=0.8 --width=0.8 ' .. log_helper
		vim.cmd(cmd)
	end,
	{noremap= true, silent = true}
)

-- lsp
vim.lsp.enable({
  "ts_ls",
})

vim.diagnostic.config({ virtual_text = true })

-- completion
local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
		keymap = { preset = 'super-tab' },
    completion = { documentation = { auto_show = false } },
    sources = { default = { 'lsp', 'path', 'buffer' } },
    fuzzy = { implementation = "rust" }
})

-- autocommands
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.keymap.set('n', '<C-c>', '<cmd>bd<CR>', { buffer = true, silent = true })
	end
})
