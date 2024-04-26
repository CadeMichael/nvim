return {
  {
    'voldikss/vim-floaterm',
    config = function()
      vim.g.floaterm_width = 0.95
      vim.g.floaterm_height = 0.95
      vim.keymap.set('n', '<leader>g', ':FloatermNew lazygit<CR>', { desc = "Lazygit" })
      vim.keymap.set({ 'n', 'i' }, '<C-Space>', '<cmd>FloatermToggle<CR>', { desc = 'toggle term' })
      vim.keymap.set('t', '<C-Space>', '<cmd>FloatermToggle<CR>', { desc = 'toggle term' })
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'sindrets/diffview.nvim',
        config = function()
          local diffview = require 'diffview'
          vim.keymap.set('n', '<leader>ho', diffview.open, { desc = 'open diffview' })
          vim.keymap.set('n', '<leader>hc', diffview.close, { desc = 'close diffview' })
        end
      },
    },
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "stage hunk" })
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "reset hunk" })
          map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = "visual stage hunk" })
          map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = "visual reset hunk" })
          map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "stage buffer" })
          map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "undo stage buffer" })
          map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "gitsigns reset buffer" })
          map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "preview hunk" })
          map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = "blame line" })
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "loggle current line blame" })
          map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "toggle deleted" })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      })
    end,
  },
}
