{ config, lib, pkgs, ... }:

with lib; {
  imports = [ ];
  options = { zoxide.enable = mkEnableOption (mdDoc "zoxide; a smarter cd"); };
  config = mkIf (config.zoxide.enable) {
    home.packages = with pkgs; [ fzf ];

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.zsh = {
      shellAliases = {
        cd = "z";
        cdi = "zi";
      };
    };
  };
}

