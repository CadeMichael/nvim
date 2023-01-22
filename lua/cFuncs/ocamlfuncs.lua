local repl = "utop"
local replid

local function dune_proj()
  local found = vim.fn.findfile("dune", ".;")
  if found ~= "" then
    return true
  else
    return false
  end
end

function GetUtopId()
  if replid ~= nil then
    print(replid)
  else
    print("No Active Repl...")
  end
end

function OpenUtop()
  local cmd = repl
  if dune_proj() then
    cmd = "dune" .. " " .. repl
  end
  vim.cmd [[wincmd n]]
  vim.cmd [[wincmd J]]
  print(cmd)
  replid = vim.fn.termopen(cmd)
end
