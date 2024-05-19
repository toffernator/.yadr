{ config, lib, pkgs, vars, ... }:

let
  modifier = config.wayland.windowManager.sway.config.modifier;
  dotfilesDir =
    config.lib.file.mkOutOfStoreSymlink "${vars.homeDir}/.yadr/dotfiles";
in {
  options = {
    sway = {
      enable = lib.mkEnableOption
        (lib.mdDoc "sway configuration, make sure to also enable it in nixos");
    };
  };
  config = lib.mkIf (config.sway.enable) {
    home.packages = with pkgs; [
      fuzzel
      swww
      networkmanagerapplet
      dunst
      grim
      slurp
      wl-clipboard
    ];

    programs.zsh = {
      profileExtra = "${pkgs.sway}/bin/sway";
      initExtra = ''
        eval $(ssh-agent) &> /dev/null
        ssh-add $HOME/.ssh/github_ed25519 &> /dev/null
        ssh-add $HOME/.ssh/uu_gitlab_ed25519 &> /dev/null
        ssh-add $HOME/.ssh/pi_ed25519 &> /dev/null
      '';
    };

    wayland.windowManager.sway = {
      enable = true;
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "${pkgs.fuzzel}/bin/fuzzel";

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
              "${pkgs.swww}/bin/swww img ${vars.homeDir}/.yadr/backgrounds/.local/wallhaven-rrxyxw_1920x1080.png";
            always = true;
          }
          {
            command = "${pkgs.swww}/bin/swww-daemon & disown";
            always = true;
          }
        ];

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
        assign [app_id="Alacritty"] workspace number 1
        assign [app_id="firefox"] workspace number 2
      '';
    };

    home.file = {
      fuzzel = {
        enable = true;
        source = "${dotfilesDir}/fuzzel/fuzzel.ini";
        target = ".config/fuzzel/fuzzel.ini";
      };
    };
  };
}

