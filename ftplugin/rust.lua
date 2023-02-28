vim.opt_local.listchars = ({ eol = '↵', multispace = "   >" })

local rt = require('rust-tools')
local help = require('cFuncs.helpers')
require("nvim-treesitter.configs").setup{
  indent = {enable = true},
}

local function rustFmt ()
  help.filecmd("rustfmt")
end

vim.keymap.set('n', '<Space>;', 'A;<Esc>')
-- vim.keymap.set('i', '<C-;>', '<Esc>A;')
vim.keymap.set('n', '<Space>r', '<cmd>RustRun<CR>')
vim.keymap.set('n', '<C-c>f', rustFmt)

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n",
        "K",
        rt.hover_actions.hover_actions,
        { buffer = bufnr }
      )
      -- Code action groups
      vim.keymap.set("n",
        "<Leader>a",
        rt.code_action_group.code_action_group,
        { buffer = bufnr }
      )
      -- inlay hinting
      vim.keymap.set("n",
        "<Leader>h",
        rt.inlay_hints.enable,
        { buffer = bufnr }
      )
      vim.keymap.set("n",
        "<Leader>uh",
        rt.inlay_hints.disable,
        { buffer = bufnr }
      )
    end,
  },
})
