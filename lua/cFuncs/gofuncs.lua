-- take string data and decide if there is an Error
function HandleData(data)
  local output = {}
  for _, v in ipairs(data) do
    table.insert(output, v)
  end
  -- get the output as a string
  local msg = ''
  -- check output
  if output then
    -- compose message from data
    for _, v in ipairs(data) do
      msg = msg .. v .. "\n"
    end
  end
  -- if there is output message user
  if #msg > 1 then
    vim.api.nvim_notify(msg, vim.log.levels.INFO, {})
  end
end

function GoRunFile()
  local file = vim.api.nvim_buf_get_name(0)
  local command = "go run " .. file
  vim.fn.jobstart(vim.fn.split(command), {
    -- allows proper newlines
    stderr_buffered = true,
    stdout_buffered = true,
    cwd = vim.fn.getcwd(),
    -- handle err / out
    on_stderr = function(_, data)
      -- check data
      if #data > 1 then
        HandleData(data)
      end
    end,
    on_stdout = function(_, data)
      -- check data
      if #data > 1 then
        HandleData(data)
      else
        vim.api.nvim_notify("File Ran", vim.log.levels.INFO, {})
      end
    end,
  })
end

function GoBuildProj()
  -- try lsp dirs
  local dir = vim.lsp.buf.list_workspace_folders()[1]
  -- prevent blank dir
  dir = dir or vim.fn.getcwd()
  local command = "go build"
  vim.fn.jobstart(vim.fn.split(command), {
    -- allows proper newlines
    stderr_buffered = true,
    stdout_buffered = true,
    cwd = dir,
    -- handle err / out
    on_stderr = function(_, data)
      -- check data
      if #data > 1 then
        HandleData(data)
      end
    end,
    on_stdout = function(_, data)
      -- check data
      if #data > 1 then
        HandleData(data)
      else
        -- no errors in build
        vim.api.nvim_notify("Project Built", vim.log.levels.INFO, {})
      end
    end,
  })
end
