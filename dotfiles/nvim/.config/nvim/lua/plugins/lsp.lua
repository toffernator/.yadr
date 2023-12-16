-- TODO:
-- - Where do I define keymaps?
-- - I want better compile errors in nvim

return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        config = function()
            -- TODO: Figure out what half of it does and clean-up
            
            local lsp = require("lsp-zero")
            lsp.extend_lspconfig()

            lsp.preset("recommended")

            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            lsp.setup()

            local cmp = require('cmp')
            local cmp_action = require('lsp-zero').cmp_action()
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ['<Tab>'] = nil,
                    ['<S-Tab>'] = nil
                }),
                sources = {
                    { name = 'nvim_lsp' },
                }
            })

            lsp.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = {
                    error = 'E',
                    warn = 'W',
                    hint = 'H',
                    info = 'I'
                }
            })

            lsp.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>lof", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end)

            lsp.setup()

            vim.diagnostic.config({
                virtual_text = true
            })

            local lspconfig = require("lspconfig")
            lspconfig.tsserver.setup({
                filetypes = { "astro", "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
            })
            lspconfig.tailwindcss.setup {}
            lspconfig.pyright.setup {}
            lspconfig.html.setup {}
            lspconfig.gopls.setup {}
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {
                                'vim',
                                'require'
                            },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }
            lspconfig.nil_ls.setup {}
            lspconfig.astro.setup {}
            lspconfig.eslint.setup({
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            })
        end
    },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
}
