{ inputs, outputs, vars, lib, config, pkgs, ... }:

{
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ./parts/programs
    ./parts/editors
    ./parts/utilities
    ./parts/shells

    # vars.machine determines which config is mkIf'd
    ./machines
  ];

  # Perform default configuration
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Utils
    jq
    tldr
    ffmpeg
    devenv
    rHttp
    httpie

    # Git
    gh
    lazygit

    # Apps
    alacritty
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      eval $(ssh-agent) &> /dev/null
      ssh-add $HOME/.ssh/github_ed25519 &> /dev/null
    '';
  };

  zsh.enable = true;
  alacritty.enable = true;
  git.enable = true;
  neovim.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

