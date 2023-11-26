return { 
    -- gruvbox.nvim is the main colorscheme, therefor it has priority 1000 and
    -- lazy load is false
    "ellisonleao/gruvbox.nvim", 
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme gruvbox]])
        
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
}
