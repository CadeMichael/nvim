local keymap = vim.api.nvim_set_keymap
keymap('n', '<Space>c', ':GoCmt<CR>', {noremap = false, silent = true})
keymap('n', '<Space>f', ':GoFmt<CR>', {noremap = false, silent = true})
