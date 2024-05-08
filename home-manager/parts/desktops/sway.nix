{ config, lib, pkgs, ... }:

let
  dotfilesDir = config.lib.file.mkOutOfStoreSymlink config.sway.dotfiles;
  modifier = config.wayland.windowManager.sway.config.modifier;
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
    home.packages = with pkgs; [
      rofi
      swww
      networkmanagerapplet
      dunst
      grim
      slurp
      wl-clipboard
    ];

    wayland.windowManager.sway = {
      enable = true;
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "rofi -show run";

        startup = [
          # FIXME: This isn't working. I am not sure if nm-applet does not show because of swaybar or not. swww doesn't seem to be working very well either.
          # Logs talk about some IconP thing not being there?
          {
            command =
              "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator & disown";
          }
          {
            command = "${pkgs.swww}/bin/swww kill";
            always = true;
          }
          {
            command =
              "${pkgs.swww}/bin/swww img /home/toffer/.yadr/backgrounds/wallhalla-77-1920x1080.jpg";
            always = true;
          }
          {
            command = "${pkgs.swww}/bin/swww-daemon";
            always = true;
          }
        ];

        # TODO: Assign workspaces

        keybindings = lib.mkOptionDefault {
          "${modifier}+Tab" = "workspace back_and_forth";
          "${modifier}+Shift+P" = ''
            exec ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png'';
        };

        window = {
          titlebar = false;
          border = 0;
        };
        floating = {
          titlebar = false;
          border = 0;
        };
        gaps = { inner = 10; };
      };
    };
  };
}
