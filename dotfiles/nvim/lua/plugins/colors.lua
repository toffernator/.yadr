return {
    {
        "Shatur/neovim-ayu",
        lazy = false,
        config = function()
            require('ayu').setup({
                overrides = {
                    Normal = { bg = "None" },
                    ColorColumn = { bg = "None" },
                    SignColumn = { bg = "None" },
                    Folded = { bg = "None" },
                    FoldColumn = { bg = "None" },
                    CursorLine = { bg = "None" },
                    CursorColumn = { bg = "None" },
                    WhichKeyFloat = { bg = "None" },
                    VertSplit = { bg = "None" },
                },
            })

            vim.cmd([[colorscheme ayu]])
        end
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        config = function()
            require("cyberdream").setup({
                transparent = true,
                italic_comments = true,
                hide_fillchars = true,
                borderless_telescope = true,
                terminal_colors = true,
            })
        end
    },
    { "nyoom-engineering/oxocarbon.nvim" },
    { "xiyaowong/transparent.nvim" }
}
