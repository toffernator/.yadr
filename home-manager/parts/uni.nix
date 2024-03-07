{ config, lib, pkgs, ... }:

with lib; {
  imports = [ ];
  options = { uni.enable = mkEnableOption (mdDoc "uni"); };
  config = mkIf (config.uni.enable) {
    home.packages = with pkgs; [ zotero ghc cabal-install ];
  };
}

