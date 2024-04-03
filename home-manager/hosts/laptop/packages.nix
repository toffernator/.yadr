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
    anki-bin

    # Apps
    chromium
    alacritty
    tmux
  ];
  packagesUnstable = with pkgs.unstable; [
    # Uni
    emacs-gtk
    (agda.withPackages (agdaPkgs: [ agdaPkgs.standard-library ]))
    # TODO:
    # agda-mode setup
    # echo "standard-library" > ~/.agda/defaults
  ];
in {
  imports = [ ../../parts/utilities/zoxide.nix ];
  config = {
    home.packages = packages ++ packagesUnstable;
    zoxide.enable = true;
  };
}

