-- Read more about lsp-zero: https://lsp-zero.netlify.app/v3.x/
--
--
local map = function(keys, func, bufnr, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, remap = false, desc = desc })
end
return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        config = function()
            -- Black wizardry sets up lsp-zero
            local lsp_zero = require("lsp-zero")
            lsp_zero.preset("recommended") -- Can't find any documentation on what this does
            lsp_zero.extend_lspconfig()    -- Has something to do with cmp integrations
            lsp_zero.on_attach(function(_, bufnr)
                local telescope = require("telescope.builtin")
                map("gd", telescope.lsp_definitions, bufnr, "[D]efinition")
                map("gr", telescope.lsp_references, bufnr, "[R]eferences")
                map("gI", telescope.lsp_implementations, bufnr, "[I]mplementations")
                map("D", telescope.lsp_type_definitions, bufnr, "[D]efinition")
                map('<leader>cs', require('telescope.builtin').lsp_document_symbols, bufnr, '[S]ymbols')
                map('<leader>cw', require('telescope.builtin').lsp_dynamic_workspace_symbols, bufnr,
                    '[W]orkspace Symbols')
                map('<leader>cr', vim.lsp.buf.rename, bufnr, '[R]ename')
                map('<leader>ca', vim.lsp.buf.code_action, bufnr, '[A]ction')
                map("<leader>co", function() vim.diagnostic.open_float() end, bufnr, "[O]pen Float")
                map('ch', vim.lsp.buf.hover, bufnr, '[H]over')
                map('gD', vim.lsp.buf.declaration, bufnr, '[D]eclaration')
                map("[d", function() vim.diagnostic.goto_prev() end, bufnr, "Previous [D]iagnostic")
                map("]d", function() vim.diagnostic.goto_next() end, bufnr, "Next [D]iagnostic")
            end)

            lsp_zero.set_preferences({
                suggest_lsp_servers = false,
                sign_icons = {
                    error = 'E',
                    warn = 'W',
                    hint = 'H',
                    info = 'I'
                }
            })

            -- Auto-completion
            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<Enter>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
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

            -- For setting up additional servers see:
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            local servers = {
                bashls = {},
                dockerls = {},
                docker_compose_language_service = {},
                html = {},
                tailwindcss = {},
                ts_ls = {
                    filetypes = { "astro", "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
                },
                elixirls = {
                    cmd = { "/nix/store/q4q6vcqyxch7z4ivlr2n6mcaaljmqih9-elixir-ls-0.24.1/bin/elixir-ls" }
                },
                eslint = {
                    on_attach = function(_, bufnr)
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            command = "EslintFixAll",
                        })
                    end,
                },
                astro = {},
                gopls = {},
                templ = {
                    cmd = { "nix", "run", "github:a-h/templ", "--", "lsp" }
                },
                rust_analyzer = {},
                omnisharp = {
                    cmd = { "OmniSharp" },
                    settings = {
                        FormattingOptions = {
                            -- Enables support for reading code style, naming convention and analyzer
                            -- settings from .editorconfig.
                            EnableEditorConfigSupport = true,
                            -- Specifies whether 'using' directives should be grouped and sorted during
                            -- document formatting.
                            OrganizeImports = true,
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
                },
                nil_ls = {},
                nixd = {},
                pyright = {},
                lua_ls = {
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
                },
                typst_lsp = {
                    settings = {
                        exportPdf = "onType"
                    }
                },
                yamlls = {
                    schemaStore = {
                        -- You must disable built-in schemaStore support if you want to use
                        -- this plugin and its advanced options like `ignore`.
                        enable = false,
                        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                        url = "",
                    },
                    schemas = require('schemastore').yaml.schemas(),
                }
            }

            local lspconfig = require("lspconfig")
            for language, config in pairs(servers) do
                lspconfig[language].setup(config)
            end
        end,
    },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    { 'Hoffs/omnisharp-extended-lsp.nvim' },
    { "b0o/schemastore.nvim" }
}
