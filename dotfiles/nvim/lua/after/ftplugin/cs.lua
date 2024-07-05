vim.keymap.set("n", "gr", function() require('omnisharp_extended').telescope_lsp_references() end)
vim.ketmap.set("n", "gd", function() require('omnisharp_extended').telescope_lsp_definition() end)
vim.keymap.set("n", "D", function() require('omnisharp_extended').telescope_lsp_type_definition() end)
vim.keymap.set("n", "gI", function() require('omnisharp_extended').telescope_lsp_implementation() end)
