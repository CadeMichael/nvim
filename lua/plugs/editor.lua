return {
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
    end
  },
  {                                                           
    'stevearc/oil.nvim',                                      
    config = function()                                       
      local oil = require('oil')                              
      require('oil').setup({                                  
        win_options = {                                       
          signcolumn = "yes:2",                               
        }                                                     
      })                                                      
      vim.keymap.set('n', '<Space>.', oil.toggle_float, { desc = 'open tree' })                       end                                                       
  },
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
  },
  {
    "voldikss/vim-floaterm",
    config = function()
      local default = "FloatermNew --autoclose=1 --height=0.8 --width=0.8 "
      local function lg()
        vim.cmd(default .. "lazygit")
      end
      local function sqlit()
        vim.cmd(default .. "sqlit")
      end
      Map('n', '<Space>lg', lg, Opts)
      Map('n', '<Space>sq', sqlit, Opts)
    end
  }
}
