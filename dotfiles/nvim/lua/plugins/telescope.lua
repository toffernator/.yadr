-- TODO:
-- Look into media-files:
-- "nvim-telescope/telescope-media-files.nvim"
-- in init: telescope.load_extension("media_files")
-- manix telescope

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
        { "tsakirist/telescope-lazy.nvim" },
        { "ghassan0/telescope-glyph.nvim" },
        { "xiyaowong/telescope-emoji.nvim" },
        { "nvim-telescope/telescope-github.nvim" }
    },
    event = 'VimEnter',
    tag = '0.1.x',
    config = function()
        require('telescope').setup {
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
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        }

        -- Enable Telescope extensions if they are installed
        local extensions = { "fzf", "ui-select", "lazy", "emoji", "glyph", "gh" }
        for _, e in pairs(extensions) do
            pcall(require("telescope").load_extension, e)
        end

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>sn', function()
            builtin.find_files { cwd = "/home/toffer/.yadr/dotfiles/nvim" }
        end, { desc = '[S]earch [N]eovim files' })
    end,
}
