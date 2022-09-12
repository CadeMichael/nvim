local guess_command = function()
  local ft_commands = {}
  -- create a table of ftypes
  ft_commands["go"] = "go build "
  ft_commands["javascript"] = "node "
  ft_commands["lua"] = "lua "
  ft_commands["python"] = "python "
  ft_commands["rust"] = "cargo build "
  ft_commands["zig"] = "zig build-exe "

  -- get filetype
  local ft = vim.bo.filetype
  local command = ""
  if ft_commands[ft] ~= nil then
    command = ft_commands[ft]
  end

  -- instantiate guess
  local name = vim.api.nvim_buf_get_name(0)
  if command == "" then
    command = command .. name
  end
  return command
end

local get_dir = function()
  -- get current dir
  local cur_dir = vim.fn.getcwd()
  -- see if there is a lsp root dir
  local lsp_dir = vim.lsp.buf.list_workspace_folders()[1]
  if lsp_dir ~= nil then
    cur_dir = lsp_dir
  end
  -- allow user to modify working dir
  local dir = vim.fn.input("Directory=> ", cur_dir, "file")
  return dir
end

local run_and_print = function()
  print("Compile Current Project...\n")
  -- get the working dir & command
  local dir = get_dir()
  local cmd = guess_command()
  -- allow user to change command
  local command = vim.fn.split(vim.fn.input("", cmd, "file"))
  -- make sure that a buffer only opens if there are commands
  if command ~= "" and dir ~= "" then
    local buff = vim.api.nvim_create_buf(false, true)
    vim.cmd("bel split")
    -- move to output buff
    vim.api.nvim_set_current_buf(buff)
    -- set output & run the user set command
    vim.api.nvim_buf_set_lines(buff, 0, -1, false, { "== output ==" })
    vim.fn.jobstart(command, {
      cwd = dir,
      detatch = false,
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
end

-- make user function
vim.api.nvim_create_user_command("CompileCurrent",
  function()
    -- run func
    run_and_print()
  end, {})
