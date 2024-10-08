return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "[F]ormat",
        },
    },
    opts = {
        notify_on_error = false,
        formatters_by_ft = {
            lua = { "stylua" },
            python = function(bufnr)
                if require("conform").get_formatter_info("ruff_format", bufnr).available then
                    return { "ruff_format" }
                else
                    return { "isort", "black" }
                end
            end,
            javascript = { { "prettierd", "prettier" } },
            javascriptreact = { { "prettierd", "prettier" } },
            ["javascript.tsx"] = { { "prettierd", "prettier" } },
            typescript = { { "prettierd", "prettier" } },
            typescriptreact = { { "prettierd", "prettier" } },
            ["typescript.tsx"] = { { "prettierd", "prettier" } },
            nix = { "nixfmt" },
            templ = { { "prettierd", "prettier" } },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters = {
            -- Custom formatters, intentionally empty
        },
    },
}
