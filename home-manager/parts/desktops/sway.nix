{ config, lib, pkgs, ... }:

let dotfilesDir = config.lib.file.mkOutOfStoreSymlink config.sway.dotfiles;
in with lib; {
  options = {
    sway.enable = mkEnableOption
      (mdDoc "sway configuration, make sure to also enable it in nixos");
    sway.dotfiles = mkOption {
      type = types.path;
      default = "/home/toffer/.yadr/dotfiles";
      description = lib.mdDoc
        "A path to a directory containing dotfiles for pyprland and waybar";
    };

  };
  config = mkIf (config.sway.enable) {
    wayland.windowManager.sway = { enable = true; };
  };
}

