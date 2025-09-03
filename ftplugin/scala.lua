local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

local function sbtCompile()
  local cwd = vim.fn.getcwd()
  local sbt_root = vim.lsp.buf.list_workspace_folders()[1]
  vim.cmd("cd " .. sbt_root)
  vim.cmd("!sbt compile")
  vim.cmd("cd " .. cwd)
end

local function sbt()
  local sbt_root = vim.lsp.buf.list_workspace_folders()[1]
  vim.system({ "tmux", "split-window", "-c", sbt_root, "sbt" })
end

local function sbtRun()
  local cwd = vim.fn.getcwd()
  local sbt_root = vim.lsp.buf.list_workspace_folders()[1]
  vim.cmd("cd " .. sbt_root)
  vim.system({ "sbt", "run" }, { text = true }, function(obj)
    vim.schedule(function()
      vim.api.nvim_notify(obj.stdout, vim.log.levels.INFO, {})
    end)
  end)

  vim.cmd("cd " .. cwd)
end

vim.keymap.set('n', '<Space>br', sbtRun, opts)
vim.keymap.set('n', '<Space>bc', sbtCompile, opts)
vim.keymap.set('n', '<Space>bb', sbt, opts)
