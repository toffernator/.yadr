return {
    "tpope/vim-fugitive",
    keys = {
        { "<leader>gg",  "<cmd>Git<cr>",          desc = "Git" },
        { "<leader>gap", "<cmd>Git add -p .<cr>", desc = "Git" },
        { "<leader>gci", "<cmd>Git commit<cr>",   desc = "Git" },
        { "<leader>gpu", "<cmd>Git push<cr>",     desc = "Git" },
        { "<leader>gpl", "<cmd>Git pull<cr>",     desc = "Git" },
        { "<leader>gf",  "<cmd>Git commit<cr>",   desc = "Git" },
    },
    cmd = { "Git", "G" }
}
