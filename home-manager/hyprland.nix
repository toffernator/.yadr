{ config, lib, pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar} &
    ${pkgs.swww} init &
  '';
in with lib; {
  options = {
    hyprland.enable = mkEnableOption
      (mdDoc "hyprland configuration, make sure to also enable it in nixos");
  };
  config = mkIf (config.hyprland.enable) {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        exec-once = [ "${startupScript}/bin/start" "${pkgs.firefox}" ];

        "$mod" = "SUPER";

        bind = [
          "$mod, B, exec, ${pkgs.firefox}/bin/firefox"
          "$mod, Enter, exec, ${pkgs.alacritty}/bin/alacritty"
          "$mod, M, exit"
        ];
      };
    };
  };
}

