{ config, lib, pkgs, ... }:

with lib; {
  imports = [ ];
  options = { social.enable = mkEnableOption (mdDoc "social"); };
  config = mkIf (config.social.enable) {
    home.packages = with pkgs; [ signal-desktop ];
  };
}

