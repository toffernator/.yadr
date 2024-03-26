{ pkgs, ... }:

let
  packages = with pkgs; [
    # Utils
    ffmpeg

    # Social
    signal-dekstop

    # Uni
    zotero
    ghc
    cabal-install
    agda
  ];
  packagesUnstable = with pkgs.unstable; [ vscode-fhs ];
in {
  imports = [ ];
  config = { home.packages = packages ++ packagesUnstable; };
}

