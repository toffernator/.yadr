{ inputs, outputs, lib, config, pkgs, ... }: {
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
    computerName = "Christoffers-Macbook-Pro";
    hostName = "Christoffers-MacBook-Pro";
  };

  users.users.toffer = {
    name = "toffer";
    home = "/Users/toffer";
    shell = pkgs.zsh;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nixpkgs = { hostPlatform = "x86_64-darwin"; };

  programs.zsh.enable = true;

  homebrew = { enable = true; };

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

