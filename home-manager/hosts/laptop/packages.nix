{ pkgs, ... }:

let
  packages = with pkgs; [
    # Utils
    ffmpeg

    # Social
    signal-desktop

    # Uni
    zotero
    ghc
    cabal-install
    agda

    # Apps
    chromium
    alacritty
    tmux
  ];
  packagesUnstable = with pkgs.unstable; [ vscode-fhs ];
in {
  imports = [ ];
  config = { home.packages = packages ++ packagesUnstable; };
}

