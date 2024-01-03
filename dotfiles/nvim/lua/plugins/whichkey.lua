return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        config = function()
            local wk = require("which-key")

            wk.register({
                h = { name = "harpoon" },
                g = {
                    name = "git",
                    s = { name = "search" }
                },
                l = { name = "lsp" },
                s = { name = "search" },
                C = {
                    name = "config",
                    s = { name = "search" },
                },
            }, { prefix = "<leader>" })

            local ignore_keys = { "d", "y", "Y", "k", "j", "e" }
            local ignore_conf = {}
            for _, key in pairs(ignore_keys) do
                ignore_conf[key] = "which_key_ignore"
            end
            wk.register(ignore_conf, { prefix = "<leader>" })
        end,
        cmd = { "WhichKey" },
    }
}
