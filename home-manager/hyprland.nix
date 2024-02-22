{ config, lib, pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator & disown
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
        exec-once =
          [ "${startupScript}/bin/start" "${pkgs.alacritty}/bin/alacritty" ];

        "$mod" = "SUPER";

        general.gaps_out = 5;

        # mouse movements
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod ALT, mouse:272, resizewindow"
        ];

        bind = [
          "$mod, l, movefocus, l"
          "$mod, h, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"

          "$mod, F, fullscreen,"
          "$mod, Q, killactive,"
          "$mod, M, exit"

          "$mod, B, exec, ${pkgs.firefox}/bin/firefox"
          "$mod, T, exec, ${pkgs.alacritty}/bin/alacritty"
        ];

        bindl = [
          # media controls
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"

          # volume
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ];

        bindle = [
          # volume
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"
        ];

        decoration.rounding = 5;

        windowrule = [ "workspace 1, alacritty" "workspace 2, firefox" ];
      };
    };
  };
}

