return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        config = function()
            require('gitsigns').setup {
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']h', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']h', bang = true })
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end, { desc = "[H]unk" })

                    map('n', '[h', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[h', bang = true })
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end, { desc = "[H]unk" })

                    -- Actions
                    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "[s]tage" })
                    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "[r]eset" })
                    map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = "[s]tage" })
                    map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = "[r]eset" })
                    map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "[u]ndo stage" })
                    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "[p]review" })
                    map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = "[b]lame" })
                    -- TODO: Figure out the difference between these two keymaps
                    map('n', '<leader>hd', gitsigns.diffthis, { desc = "[d]iff" })
                    map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "[D]iff" })
                    map('n', '<leader>gS', gitsigns.stage_buffer, { desc = "[S]tage buffer" })
                    map('n', '<leader>gR', gitsigns.reset_buffer, { desc = "[R]eset buffer" })

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            }
        end
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[s]tatus" })
            vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git('push') end, { desc = "[p]ush" })
            vim.keymap.set("n", "<leader>gP", function() vim.cmd.Git("pull --rebase") end, { desc = "[P]ull rebase" })
            vim.keymap.set("n", "<leader>gc", function() vim.cmd.Git("commit ") end, { desc = "[C]ommit" })
            vim.keymap.set("n", "gk", "<cmd>diffget //2<CR>")
            vim.keymap.set("n", "gj", "<cmd>diffget //3<CR>")
        end
    }
}
