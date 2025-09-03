-- tell nvim how to format comments
vim.bo.commentstring = "// %s"
local notif = require('snacks.notify')

-- build current buffer
local function kokaCompile()
  local file = vim.fn.expand("%:t")
  local binary = vim.fn.expand("%:t:r")
  -- compile source file to named binary
  vim.system({ "koka", "-o", binary, file }, { text = true }, function(obj)
    vim.schedule(function()
      if #obj.stdout > 0 then
        notif.info(obj.stdout)
      end

      if #obj.stderr > 0 then
        notif.error(obj.stderr)
      else
        -- make binary executable
        vim.system({ "chmod", "+x", binary }, { text = true }):wait()
      end
    end)
  end)
end

local function kokaRun()
  -- local file = vim.api.nvim_buf_get_name(0)
  local dir = vim.fn.expand('%:p:h')
  local binary = vim.fn.expand("%:p:r")
  local exists = vim.fn.executable("./" .. binary)
  if not exists then
    print("binary [" .. binary .. "]" .. " not found")
    return nil
  end
  vim.system({
    "tmux", "split-window", "-c", dir,
    "sh", "-c", string.format("%s; echo '\n[press enter to close]'; read", binary)
  })
end

local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

keymap('n', '<Space>br', kokaRun, opts)
keymap('n', '<Space>bb', kokaCompile, opts)
