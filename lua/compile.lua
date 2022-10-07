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
    -- use guess
    command = ft_commands[ft]
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

vim.api.nvim_create_user_command("CompileCurrent",
function ()
  Compile()
end, {})

function Compile()
  print("Compile Current Project...\n")
  -- get dir and cmd
  local dir = get_dir()
  local cmd = guess_command()
  -- create blank buf
  vim.cmd("wincmd n")
  vim.cmd("wincmd J")
  -- allow user to change command
  local command = vim.fn.input("", cmd, "file")
  -- cd to dir and run command
  vim.fn.termopen("cd " .. dir .. " && " .. command)
end
