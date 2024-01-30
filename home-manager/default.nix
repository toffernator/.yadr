{ config, pkgs, ... }:

let
  config_sym_dir =
    config.lib.file.mkOutOfStoreSymlink "/home/toffer/.yadr/dotfiles";
in {
  home.username = "toffer";
  home.homeDirectory = "/home/toffer";

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

    # TODO: Move to modules/editors/nvim.nix
    neovim
    # For language servers and neovim plugin
    gcc
    nodejs_20
    python312
    go
    ripgrep
    rustc
    rust-analyzer
    haskell-language-server
    nil
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-langservers-extracted
    nodePackages."@tailwindcss/language-server"
    nodePackages."@astrojs/language-server"
    nodePackages_latest.pyright
    gopls
    typst-lsp
    prettierd
    nodePackages.prettier
    lua-language-server
    vscode-langservers-extracted
    fd
    nixfmt
  ];

  home.file = {
    "nvim" = {
      enable = true;
      source = "${config_sym_dir}/nvim";
      target = ".config/nvim";
      recursive = true;
    };
  };

  home.stateVersion = "23.11";
}
