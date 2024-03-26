return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme gruvbox]])
        end,
    },
    { "RRethy/base16-nvim" },
    { "bluz71/vim-moonfly-colors" },
    { "nyoom-engineering/oxocarbon.nvim" },
    { 'kepano/flexoki-neovim',           name = 'flexoki' }
}
