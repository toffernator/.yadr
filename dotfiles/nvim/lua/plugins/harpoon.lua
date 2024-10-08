return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[A]dd" })
        vim.keymap.set("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "[E]xplore" })
        vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "File [1]" })
        vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "File [2]" })
        vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "File [3]" })
        vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "File [4]" })
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
}
