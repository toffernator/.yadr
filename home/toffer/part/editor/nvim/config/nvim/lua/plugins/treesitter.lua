return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            -- TODO: Set-up treesitter context
            -- { "nvim-treesitter/nvim-treesitter-context" }
        },
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html", "typescript", "tsx", "astro" },
                sync_install = false,
                auto_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
}
