vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.cmd.colorscheme 'gruvbox'

-- transparent BG
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
