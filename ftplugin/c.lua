local function cmakeBuild()
  local cwd = vim.fn.getcwd()
  local build_dir = vim.fs.find("build", { upward = true, limit = 5, type = "directory" })[1]
  build_dir = build_dir and build_dir or function()
    vim.api.nvim_notify("no build/ in project...", vim.log.levels.ERROR, {})
    return nil
  end
  vim.cmd("cd " .. build_dir)

  vim.system({ "cmake", ".." }, { text = true }, function(obj)
    vim.schedule(function()
      if #obj.stdout > 0 then
        vim.api.nvim_notify(obj.stdout, vim.log.levels.INFO, {})
      end

      if #obj.stderr > 0 then
        vim.api.nvim_notify("make failed...", vim.log.levels.ERROR, {})
        vim.api.nvim_notify(obj.stderr, vim.log.levels.WARN, {})
      else
        vim.api.nvim_notify("make complete...", vim.log.levels.INFO, {})
      end
    end)
  end)
  vim.cmd("cd " .. cwd)
end

local function makeBuild()
  local cwd = vim.fn.getcwd()
  local build_dir = vim.fs.find("build", { upward = true, limit = 5, type = "directory" })[1]
  build_dir = build_dir and build_dir or function()
    vim.api.nvim_notify("no build/ in project...", vim.log.levels.ERROR, {})
    return nil
  end
  vim.cmd("cd " .. build_dir)

  vim.system({ "make" }, { text = true }, function(obj)
    vim.schedule(function()
      if #obj.stdout > 0 then
        vim.api.nvim_notify(obj.stdout, vim.log.levels.INFO, {})
      end

      if #obj.stderr > 0 then
        vim.api.nvim_notify("make failed...", vim.log.levels.ERROR, {})
        vim.api.nvim_notify(obj.stderr, vim.log.levels.WARN, {})
      else
        vim.api.nvim_notify("make complete...", vim.log.levels.INFO, {})
      end
    end)
  end)
  vim.cmd("cd " .. cwd)
end

local function runBinary()
  local cwd = vim.fn.getcwd()
  local build_dir = vim.fs.find("build", { upward = true, limit = 5, type = "directory" })[1]
  build_dir = build_dir and build_dir or function()
    vim.api.nvim_notify("no build/ in project...", vim.log.levels.ERROR, {})
    return nil
  end
  vim.cmd("cd " .. build_dir)
  local binaries = vim.fs.find(
    function(name, path)
      return vim.fn.executable(path .. "/" .. name) == 1
    end,
    { type = "file", limit = 1, path = build_dir }
  )
  local binary = binaries and binaries[1] or function()
    vim.api.nvim_notify("no binaries in build/...", vim.log.levels.ERROR, {})
  end

  vim.system({ binary }, { text = true }, function(obj)
    vim.schedule(function()
      if #obj.stdout > 0 then
        vim.api.nvim_notify(obj.stdout, vim.log.levels.INFO, {})
      end

      if #obj.stderr > 0 then
        vim.api.nvim_notify("run failed...", vim.log.levels.ERROR, {})
        vim.api.nvim_notify(obj.stderr, vim.log.levels.WARN, {})
      else
        vim.api.nvim_notify("run complete...", vim.log.levels.INFO, {})
      end
    end)
  end)
  vim.cmd("cd " .. cwd)
end

local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

keymap('n', '<Space>M', makeBuild, opts)
keymap('n', '<Space>cr', runBinary, opts)
keymap('n', '<Space>cb', cmakeBuild, opts)
