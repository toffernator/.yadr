{ inputs, outputs, lib, config, pkgs, ... }:  {
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

    nixpkgs = {
      hostPlatform = "x86_64-darwin";
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; }))
    ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  nix = {
    # Nix Package Manager Settings
    gc = {
      # Garbage Collection
      automatic = true;
      # dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable; # Enable Flakes
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  programs.zsh.enable = true;

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };
 
  homebrew = {
    enable = true;
 
    casks = [
    ];
  };

  # TODO: I think home-manager needs to deal enable .zsh to auto-load the new env of packages. That and split up your home.nix.
  # This will need dotnet@7, nvim, aws, docker-desktop, Rider, Webstorm, Vscodium, a mac tiling wm.
}