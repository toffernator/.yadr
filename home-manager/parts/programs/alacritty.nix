{ config, lib, ... }:

with lib;
let dotfilesDir = config.lib.file.mkOutOfStoreSymlink config.alacritty.dotfiles;
in {
  imports = [ ];
  options = {
    alacritty.enable = mkEnableOption (mdDoc "");
    alacritty.dotfiles = mkOption {
      type = types.path;
      default = "/home/toffer/.yadr/dotfiles/alacritty";
      description = lib.mdDoc "The path to the dotfiles configuring alacritty";
    };
  };
  config = mkIf (config.alacritty.enable) {
    programs.alacritty = { enable = true; };
    home.file = {
      "alacritty" = {
        source = dotfilesDir;
        target = ".config/alacritty";
        recursive = true;
      };
    };
  };
}

