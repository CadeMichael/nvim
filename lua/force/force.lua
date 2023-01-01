-- https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm
-- apexcode
local fc = require('force.forceCommands')

vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead", "BufEnter" },
  {
    pattern = { "*.apex", "*.cls", "*.trigger" },
    callback = function()
      vim.bo.filetype = 'apexcode'
      local ft_to_parser = require "nvim-treesitter.parsers".filetype_to_parsername
      ft_to_parser.apexcode = "java"
      vim.o.expandtab = false
      vim.o.tabstop = 4
      vim.o.shiftwidth = 4
      vim.o.softtabstop = 4
    end
  }
)

local function runForceCmd(command, dir)
  vim.fn.jobstart(command, {
    -- allows proper newlines
    stderr_buffered = true,
    stdout_buffered = true,
    cwd = dir,
    -- handle err / out
    on_stderr = function(_, data)
      for _, v in ipairs(data) do
        if v ~= '' and v ~= nil then
          vim.api.nvim_notify("Command Error", vim.log.levels.ERROR, {})
          return
        end
      end
    end,
    on_stdout = function(_, data)
      local msg = ''
      for _, v in ipairs(data) do
        if v and v ~= '' then
          msg = msg .. v .. '\n'
        end
      end
      if msg ~= '' then
        vim.api.nvim_notify(msg, vim.log.levels.INFO, {})
      end
    end,
  })
end

function CreateApexClass()
  local cName = vim.fn.input("Class Name => ", "")
  local command = fc.createClass .. cName
  local dir = vim.fn.getcwd()
  dir = vim.fn.input("Output Directory =>", dir, "file")
  runForceCmd(command, dir)
end

function CreateApexTrigger()
  local tName = vim.fn.input("Trigger Name => ", "")
  local command = fc.createTrigger .. tName
  local dir = vim.fn.getcwd()
  dir = vim.fn.input("Output Directory =>", dir, "file")
  runForceCmd(command, dir)
end

function OpenOrg()
  print("Opening Org...")
  local dir = vim.fn.getcwd()
  runForceCmd(fc.orgOpen, dir)
end

function RunAnonymousFile()
  local fName = vim.api.nvim_buf_get_name(0)
  local command = fc.execute .. fName
  vim.cmd[[wincmd n]]
  vim.cmd[[wincmd J]]
  vim.fn.termopen(command)
end
