local keymap = vim.api.nvim_set_keymap
keymap('n', '<C-i>', ':lua better_iron()<CR>', {noremap = false, silent = true})
keymap('v', '<space>r', '<Plug>(iron-visual-send)',{noremap = false, silent = true})
