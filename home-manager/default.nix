{ config, pkgs, ... }:

{
  imports = [ ./modules/neovim.nix ];

  home.username = "toffer";
  home.homeDirectory = "/home/toffer";

  neovim.enable = true;

  home.packages = with pkgs; [
    htop
    alacritty
    tmux
    jq
    gh
    tldr
    ffmpeg
    lazygit

    # Video & Audio
    alsa-utils
    pipewire
    pulseaudio
    vlc
    (wrapOBS {
      plugins = with obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    })

    vscode

    # Development
    nodePackages_latest.nodemon
    python311Packages.pip
  ];

  home.stateVersion = "23.11";
}
