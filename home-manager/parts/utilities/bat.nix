{ config, lib, pkgs, ... }:

with lib; {
  imports = [ ];
  options = { bat.enable = mkEnableOption (mdDoc "zoxide; a smarter cd"); };
  config = mkIf (config.bat.enable) {
    home.packages = with pkgs; [ delta fzf ];

    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep ];
      config = { theme = "base16"; };
    };

    programs.zsh = {
      shellAliases = {
        cat = "bat";
        diff = "batdiff --delta";
        man = "batman";
        grep = "batgrep";
      };
    };
  };
}

