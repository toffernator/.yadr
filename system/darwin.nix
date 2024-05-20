# System-level configuration shared across all darwin systems.
{ inputs, outputs, lib, config, pkgs, ... }: {
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
      };

      menuExtraClock = {
        Show24Hour = true;
        ShowDate = 0; # When space allows
      };

    };

    keyboard = {
      enableKeyMapping = true;
      swapLeftCommandAndLeftAlt = true;
    };
  };

  homebrew.casks.enable = true;
}
