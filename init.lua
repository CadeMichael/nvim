-- autoisntall packer 
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end
-- setup vimplug
local Plug = vim.fn["plug#"]
vim.call('plug#begin','~/.config/nvim/plugged')
  Plug 'jalvesaq/Nvim-R'
  Plug 'junegunn/fzf.vim'
vim.call('plug#end')

-- packer commands 
vim.cmd [[command! WhatHighlight :call util#syntax_stack()]]
vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]
-- Language Server Configuration --
-- automatic lsp installer
require'lspinstall'.setup() -- important

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end

local lsp = require "lspconfig"
local coq = require "coq"
lsp.pyright.setup(coq.lsp_ensure_capabilities({}))
lsp.lua.setup(coq.lsp_ensure_capabilities({}))
lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities({
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
}))

-- global configurations --
vim.o.swapfile = false
vim.cmd("set termguicolors")
-- keymappings --
-- nvim tree
vim.api.nvim_set_keymap('n', '<Space>n',':NvimTreeToggle<CR>',{noremap = true, silent = true})
-- fzf
vim.api.nvim_set_keymap('n', '<C-Space>', ':FZF<CR>', {noremap= true, silent = true})

-- themeing
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.g.startify_custom_header = {
"  < Neovim time! >",
"   --------------",
"    \\",
"     \\",
"         .--.",
"        |o_o |",
"        |:_/ |",
"       //   \\ \\",
"      (|     | )",
"     /'\\_   _/`\\",
"     \\___)=(___/",
}
-- galaxy line --
-- bar setup
local gl = require('galaxyline')
-- local colors = require('galaxyline.theme').default
local colors = {
	bg = '#ebdbb2',
	fg = '#282828',
	yellow = '#d79921',
	cyan = '#689d6a',
	darkblue = '#458588',
	green = '#98971a',
	orange = '#d65d0e',
	violet = '#8f3f71',
	magenta = '#b16286',
	blue = '#51afef',
	red = '#076678',
}
local condition = require('galaxyline.condition')
local gls = gl.section

-- bar -> left -> right
gls.left[1] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {n = colors.red, i = colors.green,v=colors.blue,
                          [''] = colors.blue,V=colors.blue,
                          c = colors.magenta,no = colors.red,s = colors.orange,
                          S=colors.orange,[''] = colors.orange,
                          ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                          cv = colors.red,ce=colors.red, r = colors.cyan,
                          rm = colors.cyan, ['r?'] = colors.cyan,
                          ['!']  = colors.red,t = colors.red}
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
      return '🐧'
    end,
    separator = '  ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.red,colors.bg,'bold'},
  },
}
gls.left[2] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
  },
}
gls.left[3] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.magenta,colors.bg,'bold'}
  }
}
gls.left[4] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function ()
      local tbl = {['dashboard'] = true,['']=true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = ' LSP:',
    highlight = {colors.cyan,colors.bg,'bold'}
  }
}
gls.right[1] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.violet,colors.bg,'bold'},
  }
}
gls.right[2] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {colors.violet,colors.bg,'bold'},
  }
}
gls.right[3]= {
  FileSize = {
    provider = 'FileSize',
    condition = function()
      if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
      end
      return false
      end,
    icon = '   ',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.purple},
  }
}
