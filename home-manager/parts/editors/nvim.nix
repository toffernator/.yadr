{ config, lib, pkgs, ... }:

with lib;
let dotfilesDir = config.lib.file.mkOutOfStoreSymlink config.neovim.dotfiles;
in {
  imports = [ ];
  options = {
    neovim.enable = mkEnableOption (mdDoc "neovim");
    neovim.dotfiles = mkOption {
      type = types.path;
      default = "/home/toffer/.yadr/dotfiles/nvim";
      description = lib.mdDoc "The path to the dotfiles configuring neovim";
    };
  };
  config = mkIf (config.neovim.enable) {
    home.packages = (with pkgs; [
      neovim

      # For language servers and neovim plugin
      gcc
      nodejs_20
      python312
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
    ]) ++ (with pkgs.unstable; [ go ]);

    home.file = {
      "nvim" = {
        enable = true;
        source = "${dotfilesDir}";
        target = ".config/nvim";
        recursive = true;
      };
    };
  };
}

