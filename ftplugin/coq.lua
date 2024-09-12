local keymap = vim.keymap.set
keymap('n', '<Space>cn', '<cmd>CoqNext<CR>', { desc = "CoqNext" })
keymap('n', '<Space>cq', '<cmd>CoqStop<CR>', { desc = "CoqStop" })
keymap('n', '<Space>cs', '<cmd>CoqStart<CR>', { desc = "CoqStart" })
keymap('n', '<Space>cu', '<cmd>CoqUndo<CR>', { desc = "CoqUndo" })
keymap('n', '<Space>c.', '<cmd>CoqToLine<CR>', { desc = "CoqToLine" })
