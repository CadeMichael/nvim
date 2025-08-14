local function get_project_name(dune_root)
  local handle = vim.uv.fs_scandir(dune_root)
  if handle then
    while true do
      local name, type = vim.uv.fs_scandir_next(handle)
      if not name then break end
      if type == "file" and name:match("(.+)%.opam$") then
        return name:match("(.+)%.opam$") -- Extracts <proj_name>
      end
    end
  end
  return nil
end

local function duneExec()
  local cwd = vim.fn.getcwd()
  local dune_root = vim.lsp.buf.list_workspace_folders()[1]

  vim.cmd("cd " .. dune_root)

  local project_name = get_project_name(dune_root)

  local project_echo
  if project_name then
    project_echo = { "Executing dune project: [" .. project_name .. "]\n", "Normal" }
  else
    vim.schedule(function()
      vim.api.nvim_echo({ { "No .opam file found in " .. dune_root, "WarningMsg" } }, true, {})
    end)
    return nil
  end

  vim.system({ "dune", "exec", "./" .. project_name  .. ".exe" }, { text = true }, function(obj)
    vim.schedule(function()
      if #obj.stderr > 0 then
        vim.api.nvim_echo({ project_echo, { "dune exec failed...\n", "ErrorMsg", }, { obj.stderr, "WarningMsg" } }, true,
          {})
      end
      if #obj.stdout > 0 then
        vim.api.nvim_echo({ project_echo, { obj.stdout, "Normal", } }, true, {})
      end
    end)
  end)
  vim.cmd("cd " .. cwd)
end

local function duneBuild()
  local cwd = vim.fn.getcwd()
  local dune_root = vim.lsp.buf.list_workspace_folders()[1]

  local project_name = get_project_name(dune_root)

  local project_echo
  if project_name then
    project_echo = { "Building dune project: [" .. project_name .. "]\n", "Normal" }
  else
    vim.schedule(function()
      vim.api.nvim_echo({ { "No .opam file found in " .. dune_root, "WarningMsg" } }, true, {})
    end)
    return nil
  end

  vim.cmd("cd " .. dune_root)

  vim.system({ "dune", "build" }, { text = true }, function(obj)
    vim.schedule(function()
      if #obj.stdout > 0 then
        vim.api.nvim_echo({ project_echo, { obj.stdout, "Normal" } }, true, {})
      end

      if #obj.stderr > 0 then
        vim.api.nvim_echo({ project_echo, { "dune build failed...\n", "ErrorMsg" }, { obj.stderr, "WarningMsg" } }, true,
          {})
      else
        vim.api.nvim_echo({ project_echo, { "dune build complete...\n", "Normal" } }, true, {})
      end
    end)
  end)
  vim.cmd("cd " .. cwd)
end

local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = false, buffer = bufnr, }

keymap('n', '<Space>br', duneExec, opts)
keymap('n', '<Space>bb', duneBuild, opts)

-- snippets
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("ocaml", {
  s("*", fmt([[
(* {} *)
]], {
    i(0),
  })),
  s("let", fmt([[
let {} = {}
]], {
    i(1),
    i(0),
  })),
  s("match", fmt([[
match {} with
  | {}
]], {
    i(1),
    i(0),
  }))
})
