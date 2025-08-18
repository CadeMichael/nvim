return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      animate = {},
      dashboard = {
        enabled = true,
        preset = {
          header = [[
=================     ===============     ===============   ========  ========
\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //
||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||
|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||
||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||
|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||
||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||
|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||
||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||
||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||
||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||
||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||
||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||
||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||
||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||
||.=='    _-'                                                     `' |  /==.||
=='    _-'                        N E O V I M                         \/   `==
\   _-'                                                                `-_   /
`''                                                                      ``'
        ]]
        },
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
      indent = { enabled = true },
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
      { "<space>n",   function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<space>w")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.indent():map("<space>I")
          Snacks.toggle.option("conceallevel", {
            off = 0,
            on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2
          }):map("<leader>uc")
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
    'refractalize/oil-git-status.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      {
        'stevearc/oil.nvim',
        config = function()
          local oil = require('oil')
          require('oil').setup({
            win_options = {
              signcolumn = "yes:2",
            }
          })
          vim.keymap.set('n', '<Space>.', oil.toggle_float, { desc = 'open tree' })
        end
      },
    },
    config = true,
  },
  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_no_mappings = 1
    end,
    config = function()
      vim.g.slime_target = "tmux"
      -- global slimes
      Map({ 'n', 'i' }, '<C-c>c', "<Plug>SlimeConfig", Opts, "slime config")
      Map({ 'n', 'i' }, '<C-c><C-c>', "<cmd>SlimeSend0 '<c-c>' <CR>", Opts, "slime ^C")
      Map({ 'n', 'i' }, '<C-c><C-d>', "<cmd>SlimeSend0 '<c-d>' <CR>", Opts, "slime ^D")
      Map({ 'n', 'i' }, '<C-c>L', "<cmd>SlimeSend0 '<c-l>' <CR>", Opts, "slime ^L")
      Map({ 'n', 'i' }, '<C-c><C-e>', "<Plug>SlimeParagraphSend", Opts, "slime paragraph")
      Map({ 'n', 'i' }, '<C-c>l', "<Plug>SlimeLineSend", Opts, "slime line")
      Map('v', '<C-c><C-e>', "<Plug>SlimeRegionSend", Opts, "slime region")
      Map('n', '<C-c><C-s>', "%v%<Plug>SlimeRegionSend", Opts, "slime s-exp")

      -- python
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          local opts = { buffer = bufnr }
          local keymap = vim.keymap.set

          -- bindings
          keymap('n', '<C-c><C-r>', '<cmd>SlimeSend1 "python" <CR>', AddDesc(opts, "start python repl"))
          keymap('n', '<C-c>ef', function()
              Snacks.picker.files({
                confirm = function(picker, item)
                  picker:close()
                  if item then
                    local cmd = 'SlimeSend1  exec(open("' .. item.file .. '").read(), globals())'
                    vim.api.nvim_command(cmd)
                  end
                end
              })
            end,
            AddDesc(opts, 'load file in repl'))
        end,
      })
      -- racket
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "racket",
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          local opts = { buffer = bufnr }
          local keymap = vim.keymap.set

          -- bindings
          keymap('n', '<C-c><C-r>', '<cmd>SlimeSend1 "racket" <CR>', AddDesc(opts, "start racket repl"))
          keymap('n', '<C-c>el', '<cmd>SlimeSend1 (enter! #f)<CR>', AddDesc(opts, 'leave file in repl'))
          keymap('n', '<C-c>ef', function()
              Snacks.picker.files({
                confirm = function(picker, item)
                  picker:close()
                  if item then
                    local cmd = 'SlimeSend1 (enter! "' .. item.file .. '")'
                    vim.api.nvim_command(cmd)
                  end
                end
              })
            end,
            AddDesc(opts, 'enter file in repl'))
        end,
      })
    end
  },
  { -- Debugging
    'sakhnik/nvim-gdb',
    -- lua vim.api.nvim_command('vertical topleft split tags')
    -- config = function ()
    -- termwin_command = 'belowright new',   -- Assign a window for the debugging terminal
    -- end
  },
  'mattn/emmet-vim',
  {
    {
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
      },
      keys = {
        { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
    }
  }
}
