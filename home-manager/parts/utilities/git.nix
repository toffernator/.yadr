{ config, lib, pkgs, ... }:

with lib;
let dotfilesDir = config.lib.file.mkOutOfStoreSymlink config.git.dotfiles;
in {
  imports = [ ];
  options = {
    git.enable = mkEnableOption (mdDoc "");
    git.dotfiles = mkOption {
      type = types.path;
      default = "/home/toffer/.yadr/dotfiles/.gitconfig";
      description = lib.mdDoc "The path to the dotfiles configuring git";
    };
  };
  config = mkIf (config.git.enable) {
    programs.git = {
      enable = true;
      delta = {
        enable = true;
        package = pkgs.unstable.delta;
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

