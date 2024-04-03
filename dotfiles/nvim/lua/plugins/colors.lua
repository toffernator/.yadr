return {
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme oxocarbon]])
    end,
  },
  { "RRethy/base16-nvim" },
  { "bluz71/vim-moonfly-colors" },
  { "ellisonleao/gruvbox.nvim" },
  { 'kepano/flexoki-neovim',    name = 'flexoki' }
}
