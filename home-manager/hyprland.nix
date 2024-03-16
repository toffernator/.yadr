{ config, lib, pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/github_ed25519

    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    ${pkgs.swww}/bin/swww image ~/.yadr/backgrounds/wallhalla-17-1920x1080.jpg
    ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator & disown
    ${pkgs.pyprland}/bin/pypr &
  '';
  # TODO: 
  # ${pkgs.polkit-kde-agent}/bin/polk
  dotfilesDir =
    config.lib.file.mkOutOfStoreSymlink "/home/toffer/.yadr/dotfiles";
in with lib; {
  options = {
    hyprland.enable = mkEnableOption
      (mdDoc "hyprland configuration, make sure to also enable it in nixos");
  };
  config = mkIf (config.hyprland.enable) {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        env = [
          "LIBVA_DRIVER_NAME,nvidia"
          "XDG_SESSION_TYPE,wayland"
          "WLR_NO_HARDWARE_CURSORS,1"
        ];

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
          "$mod, F, fullscreen,"

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"

          "$mod, Q, killactive"
          "$mod, M, exit"

          "$mod, D, exec, ${pkgs.bemenu}/bin/bemenu-run -c"
          "$mod, B, exec, ${pkgs.firefox}/bin/firefox"
          "$mod, T, exec, ${pkgs.alacritty}/bin/alacritty"

          "$mod SHIFT,M,exec,pypr toggle stb stb-logs"
          "$mod,A,exec,pypr toggle term"
          "$mod,V,exec,pypr toggle volume"
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

        monitor = [
          "eDP-1,1920x1080@60,0x0,1,mirror"
          "HDMI-A-1,1920x1080@60,auto,1,mirror,eDP-1"
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

    home.file = {
      "pyprland" = {
        enable = true;
        source = "${dotfilesDir}/pyprland/pyprland.toml";
        target = ".config/hypr/pyprland.toml";
      };
      "waybar" = {
        enable = true;
        source = "${dotfilesDir}/waybar/config.jsonc";
        target = ".config/waybar/config.jsonc";
      };
    };
  };
}

