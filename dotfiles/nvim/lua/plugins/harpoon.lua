return {
    "ThePrimeagen/harpoon",
    keys = {
        { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>",        desc = "[A]dd" },
        { "<leader>he", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "[E]xplore" },
        { "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",         desc = "File [1]" },
        { "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",         desc = "File [2]" },
        { "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",         desc = "File [3]" },
        { "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>",         desc = "File [4]" },
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
}
