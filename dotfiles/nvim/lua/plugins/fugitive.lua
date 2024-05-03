return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[S]tatus" })
        vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git('push') end, { desc = "[P]ush" })
        vim.keymap.set("n", "<leader>gP", function() vim.cmd.Git("pull --rebase") end, { desc = "[P]ull rebase" })
        vim.keymap.set("n", "gk", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "gj", "<cmd>diffget //3<CR>")
    end
}
