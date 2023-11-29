------------------------
-- Terminal Functions --
------------------------

-- determine if there is a terminal buf
function IsTerm()
  -- get all buffers
  local bufs = vim.api.nvim_list_bufs()
  -- tables for term buffs on or off screen
  local onScreen = {}
  local offScreen = {}
  -- iterate through bufs
  for _, b in ipairs(bufs) do
    -- get name
    local bName = vim.api.nvim_buf_get_name(b)
    -- check for term
    if string.find(bName, "term://") ~= nil then
      -- get window id (non null if on screen)
      local id = vim.fn.win_findbuf(b)[1]
      -- term on screen
      if id then
        table.insert(onScreen, b)
        -- term off screen
      else
        table.insert(offScreen, b)
      end
    end
  end
  -- there is an active term
  if onScreen[1] or offScreen[1] then
    -- prioritize on screen
    if onScreen[1] then
      -- get buffer
      local b = onScreen[1]
      -- get term window id
      local id = vim.fn.win_findbuf(b)[1]
      -- set cursor to term window
      vim.api.nvim_set_current_win(id)
    else
      -- get buffer
      local b = offScreen[1]
      -- prevent new blank buff
      vim.cmd("wincmd v")
      -- move to bottom
      vim.cmd("wincmd J")
      -- set to terminal
      vim.api.nvim_set_current_buf(b)
    end
    -- terminal found
    return true
  end
  -- no term buffers
  return false
end

-- open or move to terminal window
function OpenTerm()
  -- get current buffer & name
  local buf = vim.api.nvim_get_current_buf();
  local bufName = vim.api.nvim_buf_get_name(buf);
  -- check if you're in a term
  local type = vim.fn.split(bufName, ":")[1]
  if type == "term" then
    -- switch windows
    vim.cmd [[wincmd w]]
    return
    -- find a term or make one and switch
  elseif IsTerm() ~= true then
    vim.cmd("bel split")
    vim.cmd("terminal")
  end
end

-- create user command
vim.api.nvim_create_user_command("OpenTerm",
  function()
    OpenTerm()
  end, {})

function SaveClipper()
  vim.cmd("%s/ $//")
  vim.cmd("w")
end
