-- apexcode
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead", "BufEnter" },
  {
    pattern = { "*.cls" },
    callback = function()
      vim.bo.filetype = 'apexcode'
      local ft_to_parser = require "nvim-treesitter.parsers".filetype_to_parsername
      ft_to_parser.apexcode = "java"
    end
  }
)

function CreateApexClass()
  local cName = vim.fn.input("Class Name => ", "")
  local command = "sfdx force:apex:class:create -n " .. cName
  vim.fn.jobstart(command, {
    -- allows proper newlines
    stderr_buffered = true,
    stdout_buffered = true,
    cwd = vim.fn.getcwd(),
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
      if data[1] and data[2] then
        local msg = data[1] .. '\n' .. data[2]
        vim.api.nvim_notify(msg, vim.log.levels.INFO, {})
      end
    end,
  })
end
