local actions = require('telescope.actions')
local action_state = require "telescope.actions.state"
local tsb = require('telescope.builtin')
local ts = require('telescope')

local function ocaml_debug()
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

local keymap = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

keymap('n', '<Space>d', ocaml_debug, opts)
