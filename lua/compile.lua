local testCommand = function ()
  local name = vim.api.nvim_buf_get_name(0)
  return "make " .. name
end
local print_data = function(_, data)
  if data then
    local buff = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_lines(buff, 0, -1, false, data)
  end
end
local runCommands = function (commands)
  vim.fn.jobstart(commands, {
    stdout_buffered = false,
    on_stdout = print_data,
    on_stderr = print_data,
  })
end
vim.api.nvim_create_user_command("CompileCurrent",
function()
  print("Compile Current Project...")
  local cmd = testCommand()
  local command = (vim.fn.input("", cmd))
  runCommands(command)
end, {})
