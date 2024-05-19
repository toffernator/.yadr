{ config, lib, pkgs, ... }:

{
  imports = [ ];
  options = { vscode.enable = lib.mkEnableOption (lib.mdDoc "vscode"); };
  config = lib.mkIf (config.vscode.enable) {
    home.packages = with pkgs; [ vscode-fhs ];
  };
}

