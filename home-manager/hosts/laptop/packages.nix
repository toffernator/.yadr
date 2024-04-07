{ pkgs, ... }:

let
  packages = with pkgs; [
    ffmpeg
    tmux

    signal-desktop
    chromium
    alacritty
    anki-bin

    zotero
    ghc
    cabal-install
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

