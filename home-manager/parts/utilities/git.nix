{ config, lib, pkgs, vars, ... }:

with lib;
let dotfilesDir = config.lib.file.mkOutOfStoreSymlink config.git.dotfiles;
in {
  imports = [ ];
  options = {
    git.enable = mkEnableOption (mdDoc "");
    git.dotfiles = mkOption {
      type = types.path;
      default = "${vars.homeDir}/.yadr/dotfiles/.gitconfig";
      description = lib.mdDoc "The path to the dotfiles configuring git";
    };
  };
  config = mkIf (config.git.enable) {
    programs.git = {
      enable = true;
      delta = {
        enable = true;
        package = pkgs.delta;
      };

    };

    home.file = {
      ".gitconfig" = {
        enable = true;
        source = "${dotfilesDir}";
        target = ".gitconfig";
      };
    };
  };
}

