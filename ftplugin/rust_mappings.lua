local keymap = vim.api.nvim_set_keymap
keymap('n', '<space>rr', ':RustRun<CR>',{noremap = false, silent = true})
