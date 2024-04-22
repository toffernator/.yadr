return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        config = function()
            -- Black wizardry sets up lsp-zero
            local lsp = require("lsp-zero")
            lsp.preset("recommended") -- Can't find any documentation on what this does
            lsp.extend_lspconfig() -- Has something to do with cmp integrations
            lsp.on_attach(function(_, bufnr)
                local opts = { buffer = bufnr, remap = false }
                -- custom keybinds, need a way to describe a desc for which-key,
                -- would be nice if this is done where the key-binding is defined,
                -- here, and not in the wk.register()
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
            lsp.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = {
                    error = 'E',
                    warn = 'W',
                    hint = 'H',
                    info = 'I'
                }
            })
            -- All the language servers with default configs
            lsp.setup_servers({ "pyright", "tailwindcss", "html", "gopls", "nil_ls", "astro", "gopls" })

            -- Auto-compleition
            local cmp = require('cmp')
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

            -- :help vim.diagnostic
            -- :help vim.diagnostic.config, see also the opts parameter section
            vim.diagnostic.config({
                virtual_text = true
            })

            local lspconfig = require("lspconfig")
            lspconfig.tsserver.setup({
                filetypes = { "astro", "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
            })
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
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
            --            lspconfig.eslint.setup({
            --                on_attach = function(_, bufnr)
            --                    vim.api.nvim_create_autocmd("BufWritePre", {
            --                        buffer = bufnr,
            --                        command = "EslintFixAll",
            --                    })
            --                end,
            --            })
            lspconfig.typst_lsp.setup {
                settings = {
                    exportPdf = "onType" -- Choose onType, onSave or never.
                    -- serverPath = "" -- Normally, there is no need to uncomment it.
                }
            }
            require 'lspconfig'.omnisharp.setup {
                -- cmd = { "dotnet", "/path/to/omnisharp/OmniSharp.dll" },
                cmd = { "OmniSharp" },

                settings = {
                    FormattingOptions = {
                        -- Enables support for reading code style, naming convention and analyzer
                        -- settings from .editorconfig.
                        EnableEditorConfigSupport = true,
                        -- Specifies whether 'using' directives should be grouped and sorted during
                        -- document formatting.
                        OrganizeImports = nil,
                    },
                    MsBuild = {
                        -- If true, MSBuild project system will only load projects for files that
                        -- were opened in the editor. This setting is useful for big C# codebases
                        -- and allows for faster initialization of code navigation features only
                        -- for projects that are relevant to code that is being edited. With this
                        -- setting enabled OmniSharp may load fewer projects and may thus display
                        -- incomplete reference lists for symbols.
                        LoadProjectsOnDemand = nil,
                    },
                    RoslynExtensionsOptions = {
                        -- Enables support for roslyn analyzers, code fixes and rulesets.
                        EnableAnalyzersSupport = nil,
                        -- Enables support for showing unimported types and unimported extension
                        -- methods in completion lists. When committed, the appropriate using
                        -- directive will be added at the top of the current file. This option can
                        -- have a negative impact on initial completion responsiveness,
                        -- particularly for the first few completion sessions after opening a
                        -- solution.
                        EnableImportCompletion = nil,
                        -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                        -- true
                        AnalyzeOpenDocumentsOnly = nil,
                    },
                    Sdk = {
                        -- Specifies whether to include preview versions of the .NET SDK when
                        -- determining which version to use for project loading.
                        IncludePrereleases = true,
                    },
                },
            }
        end,
    },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
}
