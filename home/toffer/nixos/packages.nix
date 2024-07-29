{ pkgs, ... }: {
  home.packages = with pkgs; [
    signal-desktop
    anki-bin

    zotero
    ghc
    cabal-install

    firefox
  ];
}
