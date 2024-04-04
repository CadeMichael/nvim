local used = require('included')

vim.opt.background = 'dark'
vim.opt.termguicolors = true

if used.Cat then
  vim.cmd.colorscheme 'catppuccin'
else
  vim.cmd.colorscheme 'gruvbox'
end

-- transparent BG
if not vim.g.neovide then
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- lsp
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "single",
  }
)

-- Diagnostics
require("trouble").setup {
  position = "right",
  icons = false,
  fold_closed = ">",    -- icon used for closed folds
  fold_open = "v",      -- icon used for open folds
  indent_lines = false, -- add an indent guide below the fold icons
}

vim.diagnostic.config({
  float = {
    border = "rounded",
  },
})

-- start screen
vim.g.startify_custom_header = {
  [[                                                      ]],
  [[   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
  [[   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
  [[   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
  [[   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
  [[   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
  [[   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
  [[                                                      ]],
}

-- Neovide
if vim.g.neovide then
  vim.o.guifont = "BlexMono Nerd Font:h16"
  vim.opt.background = 'light'
  require('catppuccin').setup {
    flavour = "latte"
  }
end
