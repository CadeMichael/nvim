vim.bo.commentstring = "// %s"

local function effkComp()
  local file = vim.fn.expand("%:t")
  -- vim.system({ "effekt", "-b", file }, { text = true })
  vim.cmd("!effekt -b " .. file)
end

local function effkRun()
  local dir = vim.fn.expand('%:p:h')
  local executable = dir .. "/out/" .. vim.fn.expand("%:t:r")
  local exists = vim.fn.executable(executable)
  if not exists then
    print("executable [" .. executable .. "]" .. " not found")
    return nil
  end
  print(executable)
  vim.system({
    "tmux", "split-window", "-c", dir,
    "sh", "-c", string.format("node %s; echo '\n[press enter to close]'; read", executable)
  })
end

local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

keymap('n', '<Space>br', effkRun, opts)
keymap('n', '<Space>bb', effkComp, opts)
