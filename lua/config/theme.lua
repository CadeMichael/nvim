local used = require('included')

vim.opt.background = 'dark'
vim.opt.termguicolors = true
if used.Dracula then
 vim.cmd.colorscheme 'dracula'
else
  vim.cmd.colorscheme 'gruvbox'
end

-- transparent BG
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- start screen
vim.g.startify_custom_header = {
  "   _   _         __     ___           ",
  "  | \\ | | ___  __\\ \\   / (_)_ __ ___  ",
  "  |  \\| |/ _ \\/ _ \\ \\ / /| | '_ ` _ \\ ",
  "  | |\\  |  __/ (_) \\ V / | | | | | | |",
  "  |_| \\_|\\___|\\___/ \\_/  |_|_| |_| |_|",
}
