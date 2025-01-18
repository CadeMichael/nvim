return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      animate = {},
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = {
        enabled = true,
        left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        right = { "fold", "git" }, -- priority of signs on the right (high to low)
        folds = {
          open = true,             -- show open fold icons
          git_hl = true,           -- use Git Signs hl for fold icons
        },
        git = {
          -- patterns to match Git signs
          patterns = { "GitSign" },
        },
        refresh = 50, -- refresh at most every 50ms
      },
      words = { enabled = true },
      picker = {
        layout = "ivy",
        win = {
          input = {
            keys = {
              ["<C-m>"] = { "toggle_maximize", mode = { "i", "n" } },
              ["<C-.>"] = { "toggle_hidden", mode = { "i", "n" } },
              ["<CR>"] = { "confirm", mode = { "n", "i" } },
            }
          },
        },
      },
    },
    keys = {
      -- lazygit
      { "<leader>gf", function() Snacks.lazygit.log_file() end,      desc = "Lazygit Current File History" },
      { "<leader>gg", function() Snacks.lazygit() end,               desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end,           desc = "Lazygit Log (cwd)" },
      -- git
      { "<leader>gB", function() Snacks.gitbrowse() end,             desc = "Git Browse" },
      -- notifications
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
      -- pickers
      { "<space>f",   function() Snacks.picker.files() end,          desc = "find files" },
      { "<space>/",   function() Snacks.picker.grep() end,           desc = "Grep" },
      { "<space>,",   function() Snacks.picker.buffers() end,        desc = "Buffers" },
      { "<space>b/",  function() Snacks.picker.grep_buffers() end,   desc = "Grep Open Buffers" },
      { "<space>h",   function() Snacks.picker.help() end,           desc = "find help" },
      { "<space>gs",  function() Snacks.picker.git_status() end,     desc = "git status" },
      { "<space>m",   function() Snacks.picker.keymaps() end,        desc = "find keymaps" },
      {
        "gr",
        function() Snacks.picker.lsp_references() end,
        nowait = true,
        desc = "References"
      },
      { "<space>E", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      -- terminal
      {
        mode = { "n", "t" },
        "<C-Space>",
        function() Snacks.terminal() end,
        desc = "Toggle Terminal"
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", {
            off = 0,
            on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2
          }):map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
        end,
      })
    end
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },
  {
    'preservim/nerdcommenter',
    config = function()
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDCustomDelimiters = { python = { left = '#', right = '' } }
      vim.keymap.set({ 'v', 'n' }, '<Space>;', '<Plug>NERDCommenterToggle', { noremap = true, silent = true })
    end
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
  },
  'dhruvasagar/vim-table-mode',
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup({
        win = {
          border = 'double'
        }
      })
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local oil = require('oil')
      require('oil').setup()
      vim.keymap.set('n', '<Space>n', oil.toggle_float, { desc = 'open tree' })
    end
  },
  {
    "jubnzv/mdeval.nvim",
    config = function()
      require 'mdeval'.setup({
        -- require_confirmation = false,
        -- Change code blocks evaluation options.
        eval_options = {
          lean = {
            command = { "lean" },
            language_code = "lean",
            exec_type = "interpreted",
            extension = "lean", -- tmp files saved to '/tmp/mdeval/'
          },
        },
      })
    end
  }
}
