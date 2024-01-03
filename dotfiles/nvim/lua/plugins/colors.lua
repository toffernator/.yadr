return {
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme oxocarbon]])
        end,
    },
    { "ellisonleao/gruvbox.nvim" },
    { "bluz71/vim-moonfly-colors" },
    { 'kepano/flexoki-neovim', name = 'flexoki' }
}
