local testCommand = function ()
  local ft_commands = {}
  ft_commands["lua"] = "lua "
  ft_commands["go"] = "go build "
  ft_commands["python"] = "python "
  ft_commands["javascript"] = "node "
  local ft = vim.bo.filetype
  local command
  if ft_commands[ft] ~= nil then
    command = ft_commands[ft]
  else
    command = ""
  end
  local name = vim.api.nvim_buf_get_name(0)
  if command == "" then
    command = command .. name
  end
  return command
end

vim.api.nvim_create_user_command("CompileCurrent",
function()
  print("Compile Current Project...\n")
  local cur_dir = vim.fn.getcwd()
  print("Directory => " .. cur_dir .."\n")
  local cmd = testCommand()
  local command = vim.fn.split(vim.fn.input("", cmd))
  local b = vim.api.nvim_create_buf(true, true)
  vim.cmd("bel split")
  vim.api.nvim_set_current_buf(b)
  vim.api.nvim_buf_set_lines(b, 0, -1, false, {"== output =="})
  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function (_, data)
      if data then
        vim.api.nvim_buf_set_lines(b, -1, -1, false, data)
      end
    end
  })
end, {})
