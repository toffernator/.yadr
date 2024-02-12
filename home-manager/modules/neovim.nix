{ config, lib, pkgs, ... }:

with lib;
let
  config_sym_dir =
    config.lib.file.mkOutOfStoreSymlink "/home/toffer/.yadr/dotfiles";
in {
  imports = [ ];
  options = { neovim.enable = mkEnableOption (mdDoc "neovim"); };
  config = mkIf (config.neovim.enable) {
    home.packages = with pkgs; [
      neovim

      # For language servers and neovim plugin
      gcc
      nodejs_20
      python312
      go
      ripgrep
      rustc
      rust-analyzer
      haskell-language-server
      nil
      nodePackages_latest.typescript-language-server
      nodePackages_latest.vscode-langservers-extracted
      nodePackages."@tailwindcss/language-server"
      nodePackages."@astrojs/language-server"
      nodePackages_latest.pyright
      gopls
      typst-lsp
      prettierd
      nodePackages.prettier
      lua-language-server
      vscode-langservers-extracted
      fd
      nixfmt
    ];

    home.file = {
      "nvim" = {
        enable = true;
        source = "${config_sym_dir}/nvim";
        target = ".config/nvim";
        recursive = true;
      };
    };
  };
}

