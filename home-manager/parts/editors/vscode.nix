{ config, lib, pkgs, ... }:

with lib; {
  imports = [ ];
  options = { vscode.enable = mkEnableOption (mdDoc "vscode"); };
  config =
    mkIf (config.utils.enable) { home.packages = with pkgs; [ vscode-fhs ]; };
}

