return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {},
        modules = {},
        sync_install = false,
        auto_install = false,
        ignore_install = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        }
      }

      -- folding
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.o.foldlevel = 32
      vim.cmd [[set nofoldenable]]
    end
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "kanagawa"
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
