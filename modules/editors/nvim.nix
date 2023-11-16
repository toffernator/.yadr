# Configure neovim

{ config, lib, pkgs, ... }:

with lib;
{
  options = {
    nvim = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  config = mkIf (config.nvim.enable) {
    programs = {
      neovim = {
        # For more about the options:
        # https://mipmip.github.io/home-manager-option-search/?query=programs.neovim
        enable = true;
        viAlias = true;
        vimAlias = true;
      };
    };

    environment.systemPackages = [
      # For language servers and plugins
      gcc
      nodejs_20
      python311
      ripgrep
      rustc
      rustup
    ];
  };
}
