local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

keymap('n', '<Space>lr', '<cmd>LeanRestartFile<CR>', opts)
keymap('n', '<Space>lv', '<cmd>LeanInfoviewToggle<CR>', opts)
keymap('n', '<Space>lt', '<cmd>LeanTermGoal<CR>', opts)
