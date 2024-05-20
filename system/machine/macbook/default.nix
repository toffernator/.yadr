{ inputs, outputs, vars, lib, config, pkgs, ... }: {
  # You can import other darwin modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as home-manager):
    # inputs.home-manager.nix-darwin.home-manager

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix
  ];

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

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [ nh ];

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
  };

  fonts = { # Fonts
    fontDir.enable = true;
    fonts = with pkgs; [
      font-awesome
      corefonts # Microsoft Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

}

