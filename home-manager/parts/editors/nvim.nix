{ config, lib, pkgs, vars, ... }:

with lib;
let dotfilesDir = config.lib.file.mkOutOfStoreSymlink config.neovim.dotfiles;
in {
  imports = [ ];
  options = {
    neovim.enable = mkEnableOption (mdDoc "neovim");
    neovim.dotfiles = mkOption {
      type = types.path;
      default = "${vars.homeDir}/.yadr/dotfiles/nvim";
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
      cargo
      haskell-language-server
      nil
      nixd
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
      omnisharp-roslyn
      dotnet-sdk_8
      fd
      nixfmt
    ]) ++ (with pkgs; [ go ]);

    home.file = {
      "nvim" = {
        enable = true;
        source = "${dotfilesDir}";
        target = ".config/nvim";
        recursive = true;
      };

      "omnisharp" = {
        enable = true;
        source = "${vars.homeDir}/.yadr/dotfiles/omnisharp";
        target = ".omnisharp";
        recursive = true;
      };
    };
  };
}

