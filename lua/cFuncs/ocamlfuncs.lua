local repl = "utop"
local replid
local cmd

local function dune_proj()
  local found = vim.fn.findfile("dune", ".;")
  if found ~= "" then
    return true
  else
    return false
  end
end

function GetMlId()
  if replid ~= nil then
    print(replid)
  else
    print("No Active Repl...")
  end
end

function OpenMlRepl()
  if cmd == nil then
    if dune_proj() then
      cmd = "dune" .. " " .. repl
    else
      cmd = "ocaml"
    end
  end
  cmd = vim.fn.input("=> ", cmd)
  vim.cmd [[wincmd n]]
  vim.cmd [[wincmd J]]
  replid = vim.fn.termopen(cmd)
end
