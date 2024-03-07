{ config, lib, pkgs, ... }:

with lib; {
  imports = [ ];
  options = { utils.enable = mkEnableOption (mdDoc "utils"); };
  config = mkIf (config.utils.enable) {
    home.packages = with pkgs; [ jq gh tldr ffmpeg lazygit ];
  };
}

