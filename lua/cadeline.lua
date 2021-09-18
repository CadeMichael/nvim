-- galaxy line --
-- bar setup
local gl = require('galaxyline')
-- local colors = require('galaxyline.theme').default
local colors = {
	bg = '#928374',
	fg = '#282828',
	yellow = '#d79921',
	cyan = '#83a598',
	darkblue = '#458588',
	green = '#b8bb26',
	fadedg = '79740e',
	orange = '#d65d0e',
	violet = '#d3869b',
	magenta = '#b16286',
	blue = '#51afef',
	red = '#076678',
	brightR = '#fb4934',
}

local condition = require('galaxyline.condition')
local gls = gl.section

-- bar -> left -> right
gls.left[1] = {
  Space1 = {
    provider = function () return ' ' end,
    highlight = {colors.fg,colors.bg}
  }
}
gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {n = colors.red, i = colors.green,v=colors.blue,
                          [' '] = colors.blue,V=colors.blue,
                          c = colors.brightR,no = colors.red,s = colors.orange,
                          S=colors.orange,[' '] = colors.orange,
                          ic = colors.yellow,R = colors.violet,Rv = colors.violet,
                          cv = colors.red,ce=colors.red, r = colors.cyan,
                          rm = colors.cyan, ['r?'] = colors.cyan,
                          ['!']  = colors.red,t = colors.red}
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
      return ''
    end,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.red,colors.bg,'bold'},
  },
}
gls.left[3] = {
  Space2 = {
    provider = function () return '⮀' end,
    separator = ' ',
    separator_highlight = {'NONE'},
    highlight = {colors.bg,'NONE'},
  }
}
gls.left[4] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,'NONE'},
  },
}
gls.left[5] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    --separator = ' ',
    --separator_highlight = {'NONE',colors.bg},
    highlight = {colors.magenta,'NONE','bold'}
  }
}
gls.left[6] = {
  Space3 = {
    provider = function () return '⮀' end,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg}
  }
}
gls.left[7] = {
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
    highlight = {colors.fg,colors.bg,'bold'}
  }
}
gls.right[1] = {
  Space4 = {
    provider = function () return '⮀' end,
    highlight = {colors.bg,'NONE'}
  }
}
gls.right[2] = {
  gsSpace = {
    provider = function () return ' ' end,
    highlight = {'NONE'}
  }
}
gls.right[3] = {
  GitIcon = {
    provider = function() return ' ' end,
    condition = condition.check_git_workspace,
    highlight = {colors.orange,'NONE','bold'},
  }
}
gls.right[4] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    --separator = ' ',
    --separator_highlight = {'NONE',colors.fg},
    highlight = {colors.orange,'NONE','bold'},
  }
}
gls.right[5] = {
  Space5 = {
    provider = function () return ' ' end,
    highlight = {'NONE'}
  }
}
