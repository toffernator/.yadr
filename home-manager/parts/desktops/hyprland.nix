{ config, lib, pkgs, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.swww}/bin/swww img /home/toffer/.yadr/backgrounds/wallhalla-17-1920x1080.jpg
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator & disown
    ${pkgs.pyprland}/bin/pypr &
    ${pkgs.swww}/bin/swww init &
  '';
  dotfilesDir = config.lib.file.mkOutOfStoreSymlink config.hyprland.dotfiles;
in with lib; {
  options = {
    hyprland.enable = mkEnableOption
      (mdDoc "hyprland configuration, make sure to also enable it in nixos");
    hyprland.dotfiles = mkOption {
      type = types.path;
      default = "/home/toffer/.yadr/dotfiles";
      description = lib.mdDoc
        "A path to a directory containing dotfiles for pyprland and waybar";
    };

  };
  config = mkIf (config.hyprland.enable) {
    home.packages = with pkgs; [
      lxqt.lxqt-policykit
      waybar
      swww
      dunst
      playerctl
      bemenu
      networkmanagerapplet
      blueberry
      pyprland
    ];

    home.sessionVariables = {
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      IBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_W = "1";
    };

    programs.zsh = {
      profileExtra = "Hyprland";
      initExtra = ''
        eval $(ssh-agent) &> /dev/null
        ssh-add $HOME/.ssh/github_ed25519 &> /dev/null
      '';
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        exec-once = [
          "${startupScript}/bin/start"
          "${pkgs.alacritty}/bin/alacritty"
          "lxqt-policykit-agent"
        ];

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

        input.touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
        };

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
        source = "${dotfilesDir}/waybar";
        target = ".config/waybar";
        recursive = true;
      };
    };
  };
}

