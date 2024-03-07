-- TODO:
-- Look into media-files:
-- "nvim-telescope/telescope-media-files.nvim"
-- in init: telescope.load_extension("media_files")
-- manix telescope

return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    init = function()
        local telescope = require("telescope")
        telescope.setup {
            defaults = {
                file_ignore_patterns = { ".git" }
            },
            pickers = {
                git_commits = { theme = "dropdown" },
            },
            extensions = {
                glyph = {
                    action = function(glyph)
                        -- insert glyph when picked
                        vim.api.nvim_put({ glyph.value }, 'c', false, true)
                    end
                },
            },
        }

        -- TODO: For some reason the dependencies aren't being installed!?
        -- local extensions = { "lazy", "emoji", "glyph", "gh" }
        local extensions = {}
        for _, extension in pairs(extensions) do
            telescope.load_extension(extension)
        end
    end,
    keys = {
        { "<leader>sf",  "<cmd>Telescope find_files hidden=true<cr>",    desc = "Search files" },
        { "<leader>ss",  "<cmd>Telescope grep_string<cr>",               desc = "Search string" },
        { "<leader>ss",  "<cmd>Telescope live_grep<cr>",                 desc = "Search live grep" },
        { "<leader>s/",  "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search pattern" },
        { "<leader>gsc", "<cmd>Telescope git_commits<cr>",               desc = "Search git commits" },
        { "<leader>Csp", "<cmd>Telescope lazy<cr>",                      desc = "Search plugins" },
    },
    cmd = { "Telescope" },
    dependencies = {
        'nvim-lua/plenary.nvim',
        "tsakirist/telescope-lazy.nvim",
        "ghassan0/telescope-glyph.nvim",
        "xiyaowong/telescope-emoji.nvim",
        "nvim-telescope/telescope-github.nvim"
    },
}
