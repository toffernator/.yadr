{ inputs, outputs, vars, lib, config, pkgs, ... }:

{
  imports = [ ../../parts/desktops ];

  config = lib.mkIf (vars.machine == "laptop") {
    sway.enable = true;

    home.packages = with pkgs; [
      signal-desktop
      anki-bin

      zotero
      ghc
      cabal-install

      firefox
    ];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.05";
  };

}
