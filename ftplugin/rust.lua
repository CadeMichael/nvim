vim.keymap.set('n', '<C-;>', 'A;')
vim.keymap.set('i', '<C-;>', '<Esc>A;')
vim.keymap.set('n', '<Space>r', '<cmd>RustRun<CR>' )
vim.keymap.set('n', '<C-c>f', function()
  local fname = vim.api.nvim_buf_get_name(0)
  vim.cmd('!rustfmt ' .. fname)
end)

local rt = require('rust-tools')

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
