vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.cmd.colorscheme 'gruvbox'

-- transparent BG
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Diagnostics
require("trouble").setup {
  icons = false,
  fold_open = "v",        -- icon used for open folds
  fold_closed = ">",      -- icon used for closed folds
  indent_lines = false,   -- add an indent guide below the fold icons
  signs = {
    -- icons / text used for a diagnostic
    error = "error",
    warning = "warn",
    hint = "hint",
    information = "info"
  },
  use_diagnostic_signs = false   -- enabling this will use the signs defined in your lsp client
}

-- start screen
vim.g.startify_custom_header = {
  "   _   _         __     ___           ",
  "  | \\ | | ___  __\\ \\   / (_)_ __ ___  ",
  "  |  \\| |/ _ \\/ _ \\ \\ / /| | '_ ` _ \\ ",
  "  | |\\  |  __/ (_) \\ V / | | | | | | |",
  "  |_| \\_|\\___|\\___/ \\_/  |_|_| |_| |_|",
}
