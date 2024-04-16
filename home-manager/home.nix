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
    ./parts/programs/alacritty.nix
    ./parts/editors/nvim.nix
    ./parts/utilities/bat.nix
    ./parts/utilities/git.nix
    ./hosts/common/packages.nix
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs.unstable; [
    # Utils
    jq
    tldr

    # Git
    gh
    lazygit

    # Apps
    firefox
  ];

  alacritty.enable = true;
  neovim.enable = true;
  git.enable = true;
  bat.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
