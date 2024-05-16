return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[A]dd" })
        vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "[E]xplore" })
        vim.keymap.set("n", "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
            { desc = "File [1]" })
        vim.keymap.set("n", "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
            { desc = "File [2]" })
        vim.keymap.set("n", "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
            { desc = "File [3]" })
        vim.keymap.set("n", "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>",
            { desc = "File [4]" })
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
}
