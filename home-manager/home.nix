# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ./parts/desktops/hyprland.nix
    ./parts/programs/alacritty.nix
    ./parts/editors/nvim.nix
    ./parts/utilities/bat.nix
    ./parts/utilities/git.nix
    ./hosts/common/packages.nix
    ./hosts/laptop/packages.nix
  ];

  home = {
    username = "toffer";
    homeDirectory = "/Users/toffer";
  };

  programs.home-manager.enable = true;

  alacritty.enable = true;
  neovim.enable = true;
  git.enable = true;
  bat.enable = true;

  programs.alacritty = { enable = true; };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
