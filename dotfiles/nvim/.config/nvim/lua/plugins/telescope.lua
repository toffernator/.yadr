return {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    keys = {
        { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Search files" },
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
} 
