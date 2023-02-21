local help = require("cFuncs.helpers")

function FileUnnittest(markerFile)
  -- look for .git or main.py
  local path = ""
  if markerFile == nil then
    path = vim.fn.finddir(".git", ".;")
    if #path <= 1 then
      path = vim.fn.findfile("main.py", ".;")
      if #path <= 1 then
        print("no python project found...")
        return
      end
    end
  else
    path = vim.fn.finddir(markerFile, ".;")
  end
  local spath = vim.fn.split(path, "/")
  table.remove(spath, #spath)
  local dir = "/" .. table.concat(spath, "/")
  local command = "python -m unittest "
  local fname = vim.api.nvim_buf_get_name(0)
  help.runCmd(command .. fname, dir, help.printData)
end
