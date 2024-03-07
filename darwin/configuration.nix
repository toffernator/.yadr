{ pkgs, lib, inputs }:

{
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
    shell = pkgs.zsh
  };

  # TODO: I think home-manager needs to deal enable .zsh to auto-load the new env of packages. That and split up your home.nix.
  # This will need dotnet@7, nvim, aws, docker-desktop, Rider, Webstorm, Vscodium, a mac tiling wm.
}