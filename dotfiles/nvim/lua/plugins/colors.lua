return {
    {
        "RRethy/base16-nvim",
        lazy = false,
        config = function()
            vim.cmd([[colorscheme base16-ayu-dark]])
        end
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        config = function()
            require("cyberdream").setup({
                -- Recommended - see "Configuring" below for more config options
                transparent = true,
                italic_comments = true,
                hide_fillchars = true,
                borderless_telescope = true,
                terminal_colors = true,
            })
        end
    },
    { "bluz71/vim-moonfly-colors" },
    { 'kepano/flexoki-neovim',           name = 'flexoki' },
    { "nyoom-engineering/oxocarbon.nvim" },
}
