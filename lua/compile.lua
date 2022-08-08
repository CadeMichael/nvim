local guess_command = function()
  local ft_commands = {}
  ft_commands["go"] = "go build "
  ft_commands["javascript"] = "node "
  ft_commands["lua"] = "lua "
  ft_commands["python"] = "python "
  ft_commands["rust"] = "cargo run "
  ft_commands["zig"] = "zig build-exe "
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

local get_dir = function()
  local cur_dir = vim.fn.getcwd()
  local lsp_dir = vim.lsp.buf.list_workspace_folders()[1]
  if lsp_dir ~= nil then
    cur_dir = lsp_dir
  end
  local dir = vim.fn.input("Directory=> ", cur_dir, "file")
  return dir
end

local run_and_print = function(buff)
  print("Compile Current Project...\n")
  local dir = get_dir()
  local cmd = guess_command()
  local command = vim.fn.split(vim.fn.input("", cmd, "shellcmd"))
  vim.api.nvim_set_current_buf(buff)
  vim.api.nvim_buf_set_lines(buff, 0, -1, false, { "== output ==" })
  vim.fn.jobstart(command, {
    cwd = dir,
    stdout_buffered = true,
    on_stderr = function(_, data)
      if data then
        vim.api.nvim_buf_set_lines(buff, -1, -1, false, data)
      end
    end,
    on_stdout = function(_, data)
      if data then
        vim.api.nvim_buf_set_lines(buff, -1, -1, false, data)
      end
    end
  })
end

vim.api.nvim_create_user_command("CompileCurrent",
  function()
    local b = vim.api.nvim_create_buf(true, true)
    vim.cmd("bel split")
    run_and_print(b)
  end, {})
