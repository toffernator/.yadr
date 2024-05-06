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
        { "Snikimonkd/telescope-git-conflicts.nvim" },
    },
    event = 'VimEnter',
    tag = '0.1.x',
    config = function()
        local telescope = require("telescope")

        telescope.setup {
            defaults = {
                file_ignore_patterns = { ".git" }
            },
            pickers = {
                git_commits = { theme = "dropdown" },
                colorscheme = {
                    enable_preview = true,
                },
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        }

        -- Enable Telescope extensions if they are installed
        local extensions = { "ui-select", "lazy", "conflicts" }
        for _, e in pairs(extensions) do
            pcall(telescope.load_extension, e)
        end

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[F]iles' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

        vim.keymap.set('n', '<leader>gc', "<cmd>Telescope conflicts<Enter>", { desc = '[C]onflicts' })

        vim.keymap.set('n', '<leader>ss', function()
            builtin.builtin { include_extensions = true }
        end, { desc = '[S]elect telescope' })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>sn', function()
            local homeDir = os.getenv("HOME")
            builtin.find_files { cwd = homeDir .. "/.yadr/dotfiles/nvim" }
        end, { desc = '[N]eovim config' })
    end,
}
