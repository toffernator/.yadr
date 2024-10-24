# Gnome Configuration
#  Enable with "gnome.enable = true;"

{ config, lib, pkgs, vars, ... }:

with lib; {
  options = {
    gnome = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.gnome.enable) {
    services = {
      xserver = {
        enable = true;
        layout = "us";
        xkbOptions = "eurosign:e";
        # Enable touchpad support (enabled default in most desktopManager).
        libinput.enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };

    environment = {
      systemPackages = with pkgs; [ gnome.adwaita-icon-theme ];
      gnome = {
        excludePackages = (with pkgs; [ gnome-tour gedit ])
          ++ (with pkgs.gnome; [
            cheese # webcam tool
            gnome-music
            gnome-terminal
            epiphany # web browser
            geary # email reader
            evince # document viewer
            gnome-characters
            totem # video player
            tali # poker game
            iagno # go game
            hitori # sudoku game
            atomix # puzzle game
          ]);
      };
    };
  };
}
