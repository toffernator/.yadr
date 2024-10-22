return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        vim.keymap.set("n", "<leader>cd", function() require("trouble").toggle("diagnostics") end,
            { desc = "[D]iagnostics" })
        vim.keymap.set("n", "<leader>cq", function() require("trouble").toggle("quickfix") end,
            { desc = "[Q]uickfixes" })
        vim.keymap.set("n", "<leader>cl", function() require("trouble").toggle("loclist") end, { desc = "[L]oclist" })
    end
}
