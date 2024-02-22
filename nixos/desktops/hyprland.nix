{ config, inputs, lib, pkgs, ... }:

with lib; {
  options = {
    hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.hyprland.enable) {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    networking.networkmanager.enable = true;

    environment.systemPackages = with pkgs; [
      waybar
      swww
      dunst
      playerctl

      # networking
      networkmanagerapplet # GUI for networkmanager
    ];
  };

}
