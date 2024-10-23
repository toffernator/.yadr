{ config, lib, pkgs, ... }:
let modifier = config.wayland.windowManager.sway.config.modifier;
in {
  imports = [ ../../emulator/foot ];

  home.packages = with pkgs; [
    fuzzel
    swww
    networkmanagerapplet
    grim
    slurp
    wl-clipboard
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "${pkgs.foot}/bin/foot";
      menu = "${pkgs.fuzzel}/bin/fuzzel";

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
    extraConfig = ''
      assign [app_id="foot"] workspace number 1
      assign [app_id="firefox"] workspace number 2
    '';
  };

  home.file = {
    fuzzel = {
      enable = true;
      source = ./fuzzel.ini;
      target = ".config/fuzzel/fuzzel.ini";
    };
  };
}