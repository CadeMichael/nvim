local function zig_exe()
  -- find the root directory based off 'build.zig' location
  local buildFile = vim.fs.find("build.zig", { type = "file", upward = true })
  local root_dir = ""
  if #buildFile > 0 then
    root_dir = vim.fs.dirname(buildFile[1])
  end
  if root_dir == "" then
    vim.api.nvim_notify("not in a zig project", vim.log.levels.INFO, {})
  end
  -- get dir with binary
  local bin_dir = root_dir .. "/zig-out/bin"
  -- find binary name
  local matches = vim.split(vim.fn.glob(bin_dir .. "/*"), "\n", { plain = true })
  -- filter out empty lines
  for i = #matches, 1, -1 do
    if matches[i] == "" then
      table.remove(matches, i)
    end
  end
  -- no binary found
  if #matches == 0 then
    vim.notify("No compiled binary found in " .. bin_dir, vim.log.levels.ERROR, {})
    return
  end
  -- get the binary to run
  local binary = matches[1]
  -- run with snacks terminal
  Snacks.terminal.open(binary, { interactive = false, cwd = root_dir })
end

local function zig_build()
  local buildFile = vim.fs.find("build.zig", { type = "file", upward = true })
  local root_dir = ""
  if #buildFile > 0 then
    root_dir = vim.fs.dirname(buildFile[1])
  end
  if root_dir == "" then
    vim.api.nvim_notify("not in a zig project", vim.log.levels.INFO, {})
  end
  Snacks.terminal.open("zig build", { interactive = false, cwd = root_dir })
end

local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()

local genOpts = function(s)
  local opts = { noremap = true, silent = true, buffer = bufnr, desc = s }
  return opts
end

keymap('n', '<Space>cc', zig_build, genOpts("zig build"))
keymap('n', '<Space>ce', zig_exe, genOpts("zig execute"))
