return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        cmd = { "WhichKey" },
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        config = function() -- This is the function that runs, AFTER loading
            local wk = require("which-key")
            require('which-key').setup()

            -- Document existing key chains
            require('which-key').register({
                c = { name = '[C]ode', _ = 'which_key_ignore' },
                d = { name = '[D]ocument', _ = 'which_key_ignore' },
                r = { name = '[R]ename', _ = 'which_key_ignore' },
                s = { name = '[S]earch', _ = 'which_key_ignore' },
                w = { name = '[W]orkspace', _ = 'which_key_ignore' },
                h = { name = '[H]arpoon', _ = 'which_key_ignore' },
                g = { name = '[G]it', _ = 'which_key_ignore' },
            }, { prefix = "<leader>" })
            local ignore_keys = { "d", "y", "Y", "k", "j", "e", "x", "q", "/", "<leader>" }
            local ignore_conf = {}
            for _, key in pairs(ignore_keys) do
                ignore_conf[key] = "which_key_ignore"
            end
            wk.register(ignore_conf, { prefix = "<leader>" })
        end,
    }
}
