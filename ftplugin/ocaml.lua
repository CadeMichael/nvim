local actions = require('telescope.actions')
local action_state = require "telescope.actions.state"
local tsb = require('telescope.builtin')
local ts = require('telescope')

local function ocamlDebug()
  local dir = vim.fn.getcwd()
  dir = vim.fn.input("*Dir*=>", dir, "file")
  local exe

  -- Override the setup for the duration of the function
  ts.setup({
    pickers = {
      find_files = {
        theme = "dropdown",
      },
    }
  })

  tsb.find_files({
    prompt_title = "Byte-Code-File",
    previewer = false,
    cwd = dir,
    attach_mappings = function(_, map)
      map('i', '<CR>', function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry then
          local filename = entry.value
          exe = filename
          vim.cmd [[wincmd n]]
          vim.cmd [[wincmd L]]
          vim.fn.termopen("ocamldebug" .. " " .. exe, { cwd = dir })
        end
      end)
      -- reset default picker theme
      ts.setup({
        pickers = {
          find_files = {
            theme = "ivy",
          }
        }
      })
      return true
    end,
  })
end

local function get_project_name(dune_root)
  local handle = vim.loop.fs_scandir(dune_root)
  if handle then
    while true do
      local name, type = vim.loop.fs_scandir_next(handle)
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

  if project_name then
    vim.api.nvim_notify("Executing dune project: " .. project_name, vim.log.levels.INFO, {})
  else
    vim.api.nvim_notify("No .opam file found in " .. dune_root, vim.log.levels.WARN, {})
    return nil
  end

  vim.system({ "dune", "exec", project_name }, { text = true }, function(obj)
    vim.schedule(function()
      if #obj.stderr > 0 then
        vim.api.nvim_notify("dune exec failed...", vim.log.levels.ERROR, {})
        vim.api.nvim_notify(obj.stderr, vim.log.levels.WARN, {})
      end
      if #obj.stdout > 0 then
        vim.api.nvim_notify(obj.stdout, vim.log.levels.INFO, {})
      end
    end)
  end)
  vim.cmd("cd " .. cwd)
end

local function duneBuild()
  local cwd = vim.fn.getcwd()
  local dune_root = vim.lsp.buf.list_workspace_folders()[1]

  vim.cmd("cd " .. dune_root)

  vim.system({ "dune", "build" }, { text = true }, function(obj)
    vim.schedule(function()
      if #obj.stdout > 0 then
        vim.api.nvim_notify(obj.stdout, vim.log.levels.INFO, {})
      end

      if #obj.stderr > 0 then
        vim.api.nvim_notify("dune build failed...", vim.log.levels.ERROR, {})
        vim.api.nvim_notify(obj.stderr, vim.log.levels.WARN, {})
      else
        vim.api.nvim_notify("dune build complete...", vim.log.levels.INFO, {})
      end
    end)
  end)
  vim.cmd("cd " .. cwd)
end

local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

keymap('n', '<Space>D', ocamlDebug, opts)
keymap('n', '<Space>dr', duneExec, opts)
keymap('n', '<Space>db', duneBuild, opts)
