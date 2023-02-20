local m = {}

m.printData = function (data)
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

return m
