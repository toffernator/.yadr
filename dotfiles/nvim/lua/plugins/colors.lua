return {
    {
        "RRethy/base16-nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme base16-ayu-dark]])
        end,
    },
    { "bluz71/vim-moonfly-colors" },
    { 'kepano/flexoki-neovim',           name = 'flexoki' },
    { "nyoom-engineering/oxocarbon.nvim" },
}
