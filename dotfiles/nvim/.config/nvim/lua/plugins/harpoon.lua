return {
    "ThePrimeagen/harpoon",
    keys = {
        { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add harpoon file" },
        { "<leader>he", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon menu" },
        { "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "First harpoon file" },
        { "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Second harpoon file" },
        { "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Third harpoon file" },
        { "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Fourth harpoon file" },
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
}

