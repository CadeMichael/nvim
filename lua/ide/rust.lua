local rt = require('rust-tools')
rt.setup({
    tools = {
        inlay_hints = {
            auto = false,
        },
    },
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n",
                "K",
                rt.hover_actions.hover_actions,
                { buffer = bufnr }
            )
            -- Code action groups
            vim.keymap.set("n",
                "<Leader>a",
                rt.code_action_group.code_action_group,
                { buffer = bufnr }
            )
            -- inlay hinting
            vim.keymap.set("n",
                "<Leader>h",
                rt.inlay_hints.enable,
                { buffer = bufnr }
            )
            vim.keymap.set("n",
                "<Leader>uh",
                rt.inlay_hints.disable,
                { buffer = bufnr }
            )
            vim.keymap.set('n',
                'gD',
                vim.lsp.buf.declaration,
                { buffer = bufnr })
            vim.keymap.set('n',
                'gd',
                vim.lsp.buf.definition,
                { buffer = bufnr })
            vim.keymap.set('n',
                '<space>D',
                vim.lsp.buf.type_definition,
                { buffer = bufnr })
            vim.keymap.set('n',
                '<space>rn', vim.lsp.buf.rename,
                { buffer = bufnr })
            vim.keymap.set('n',
                'gr', vim.lsp.buf.references,
                { buffer = bufnr })
        end,
    },
})
