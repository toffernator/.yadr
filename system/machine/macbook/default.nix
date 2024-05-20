{ inputs, outputs, vars, lib, config, pkgs, ... }: {
  networking = {
    computerName = "whackbook";
    hostName = "whackbook";
  };

  users.users."${vars.user}" = {
    name = vars.user;
    home = vars.homeDir;
    shell = pkgs.zsh;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nixpkgs = { hostPlatform = "x86_64-darwin"; };

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      font-awesome
      corefonts # Microsoft Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

}

