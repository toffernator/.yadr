return {
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                ["javascript"] = {"prettierd", "prettier"},
                ["javascriptreact"] = {"prettierd", "prettier"},
                ["typescript"] = {"prettierd", "prettier"},
                ["css"] = {"prettierd", "prettier"},
                ["html"] = {"prettierd", "prettier"},
                ["json"] = {"prettierd", "prettier"},
                ["yaml"] = {"prettierd", "prettier"},
                ["markdown"] = {"prettierd", "prettier"},
            }
        }
    },
}
