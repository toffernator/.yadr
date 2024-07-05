# System-level configuration shared across all darwin systems.
{ inputs, outputs, lib, config, pkgs, vars, ... }: {
  # Because of programs.zsh.enableCompletion in ../home-manager/macbook.nix
  environment.pathsToLink = [ "/share/zsh" ];

  # Auto optimise store is broken on darwin:
  # https://github.com/NixOS/nix/issues/7273
  nix.settings.auto-optimise-store = lib.mkForce false;

  system = {
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        QuitMenuItem = true;
        FXPreferredViewStyle = "clmv";
      };
      screencapture.location = "~/Pictures/screenshots";

      dock = {
        autohide = true;
        mru-spaces = false;
      };

      menuExtraClock = {
        Show24Hour = true;
        ShowDate = 0; # When space allows
      };

    };

    keyboard = { enableKeyMapping = true; };

  };

  fonts = {
    packages = with pkgs; [
      font-awesome
      corefonts # Microsoft Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  users.users."${vars.user}" = {
    name = vars.user;
    home = vars.homeDir;
    shell = pkgs.zsh;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  homebrew.casks.enable = true;
}
