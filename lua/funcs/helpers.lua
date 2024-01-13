local m = {}

m.printData = function(data)
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

m.runCmd = function(command, dir, handler)
  vim.fn.jobstart(command, {
    -- allows proper newlines
    stderr_buffered = true,
    stdout_buffered = true,
    cwd = dir,
    -- handle err / out
    on_stderr = function(_, data)
      -- check data
      if #data > 1 then
        handler(data)
      end
    end,
    on_stdout = function(_, data)
      -- check data
      if #data > 1 then
        handler(data)
      end
    end,
  })
end

m.filecmd = function(command)
  local file = vim.api.nvim_buf_get_name(0)
  local cmd = command .. " " .. file
  vim.cmd("!" .. cmd)
end

return m
