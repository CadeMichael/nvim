return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'neovim-treesitter/treesitter-parser-registry' },
    lazy = false,
    build = ':TSUpdate',
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'markdown',
          'markdown_inline',
          'odin',
          'python',
          'rust',
          'typescript',
        },
        callback = function()
          vim.treesitter.start()
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo.foldmethod = 'expr'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end
  },
  -- {
    -- "rebelot/kanagawa.nvim",
    -- priority = 1000,
    -- config = function()
      -- vim.cmd.colorscheme "kanagawa-dragon"
    -- end
  -- },
  {
    "navarasu/onedark.nvim",
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('onedark').setup {
      style = 'dark'
    }
    require('onedark').load()
  end
  },
  {
    'goolord/alpha-nvim',
    config = function ()
            local alpha = require'alpha'
            -- local startify = require'alpha.themes.startify'
            local dashboard = require'alpha.themes.dashboard'
            dashboard.section.header.val = {
            -- startify.section.header.val = {
[[                      .,,uod8B8bou,,.                                 ]],
[[              ..,uod8BBBBBBBBBBBBBBBBRPFT?l!i:.                       ]],
[[         ,=m8BBBBBBBBBBBBBBBRPFT?!||||||||||||||                      ]],
[[         !...:!TVBBBRPFT||||||||||!!^^""'   ||||                      ]],
[[         !.......:!?|||||!!^^""'            ||||                      ]],
[[         !.........||||                     ||||                      ]],
[[         !.........||||  ##                 ||||                      ]],
[[         !.........||||                     ||||                      ]],
[[         !.........||||                     ||||                      ]],
[[         !.........||||                     ||||                      ]],
[[         !.........||||                     ||||                      ]],
[[         `.........||||                    ,||||                      ]],
[[          .;.......||||               _.-!!|||||                      ]],
[[   .,uodWBBBBb.....||||       _.-!!|||||||||!:'                       ]],
[[!YBBBBBBBBBBBBBBb..!|||:..-!!|||||||!iof68BBBBBb....                  ]],
[[!..YBBBBBBBBBBBBBBb!!||||||||!iof68BBBBBBRPFT?!::   `.                ]],
[[!....YBBBBBBBBBBBBBBbaaitf68BBBBBBRPFT?!:::::::::     `.              ]],
[[!......YBBBBBBBBBBBBBBBBBBBRPFT?!::::::;:!^"`;:::       `.            ]],
[[!........YBBBBBBBBBBRPFT?!::::::::::^''...::::::;         iBBbo.      ]],
[[`..........YBRPFT?!::::::::::::::::::::::::;iof68bo.      WBBBBbo.    ]],
[[  `..........:::::::::::::::::::::::;iof688888888888b.     `YBBBP^'   ]],
[[    `........::::::::::::::::;iof688888888888888888888b.     `        ]],
[[      `......:::::::::;iof688888888888888888888888888888b.            ]],
[[        `....:::;iof688888888888888888888888888888888899fT!           ]],
[[          `..::!8888888888888888888888888888888899fT|!^"'             ]],
[[            `' !!988888888888888888888888899fT|!^"'                   ]],
[[                `!!8888888888888888899fT|!^"'                         ]],
[[                  `!988888888899fT|!^"'                               ]],
[[                    `!9899fT|!^"'                                     ]],
[[                      `!^"'                                           ]],
            }
            -- alpha.setup(startify.config)
         dashboard.section.buttons.val = {
             dashboard.button( "d", "explore directory" , ":Oil<CR>"),
             dashboard.button( "r", "recent files" , ":FzfLua history<CR>"),
             dashboard.button( "q", "quit" , ":qa<CR>"),
         }
         local handle = io.popen('fortune')
         local fortune = handle:read("*a")
         handle:close()
         dashboard.section.footer.val = fortune

         dashboard.config.opts.noautocmd = true

         vim.cmd[[autocmd User AlphaReady echo 'ready']]

         alpha.setup(dashboard.config)
    end
  },
}
