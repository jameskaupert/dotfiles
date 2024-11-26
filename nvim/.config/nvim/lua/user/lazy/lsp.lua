return {
    "neovim/nvim-lspconfig",
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'L3MON4D3/LuaSnip'
    },
    config = function()
        local lsp_zero = require('lsp-zero')

        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({ buffer = bufnr })

            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, bufopts)
        end)

        -- icons for sign column
        lsp_zero.set_sign_icons({
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = '»'
        })

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                "astro",
                "bashls",
                "gopls",
                "html",
                "jedi_language_server",
                "lua_ls",
                "tailwindcss",
                "ts_ls",
                "yamlls"
            },
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            }
        })
        require("lspconfig")["gdscript"].setup({
            name = "godot",
            cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
        })
        ---
        -- Autocompletion config
        ---
        local cmp = require('cmp')

        local cmp_action = lsp_zero.cmp_action()
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )

        cmp.setup({
            sources = {
                { name = "nvim_lsp" },
                { name = "buffer" }
            },
            preselect = "item",
            completion = {
                completeopt = "menu,menuone,noinsert"
            },
            mapping = cmp.mapping.preset.insert({
                -- `Enter` key to confirm completion
                ['<CR>'] = cmp.mapping.confirm({ select = false }),

                -- Ctrl+Space to trigger completion menu
                ['<C-Space>'] = cmp.mapping.complete(),

                -- Navigate between snippet placeholder
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                -- Scroll up and down in the completion documentation
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),

            }),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
        })
    end
}
