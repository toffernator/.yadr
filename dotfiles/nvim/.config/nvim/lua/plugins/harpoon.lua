return {
    "ThePrimeagen/harpoon",
    dependencies = { 'nvim-lua/plenary.nvim' }
    keys = {
        { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add harpoon file" },
        { "<leader>he", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon menu" }
    }
}

-- Old after/plugin/harpoon
-- local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")
-- 
-- vim.keymap.set("n", "<leader>a", mark.add_file)
-- vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
-- 
-- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
-- vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
-- vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
-- vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
-- See also: https://github.com/ThePrimeagen/harpoon/issues/302
-- FIXME: I can't get it to work, <leader>ha puts me in insert mode...
