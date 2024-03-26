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

    environment.variables.NIXOS_OZONE_WL = "1";

    environment.systemPackages = with pkgs; [
      lxqt.lxqt-policykit
      waybar
      swww
      dunst
      playerctl
      bemenu
      polkit-kde-agent
      networkmanagerapplet
      blueberry
      pyprland
    ];
  };

}
