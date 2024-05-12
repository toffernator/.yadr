{ config, lib, pkgs, ... }:

let
  shellAliases = {
    cd = "z";
    cdi = "zi";
  };
in with lib; {
  imports = [ ];
  options = { zoxide.enable = mkEnableOption (mdDoc "zoxide; a smarter cd"); };
  config = mkIf (config.zoxide.enable) {
    home.packages = with pkgs; [ fzf ];

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    programs.bash = { inherit shellAliases; };
    programs.zsh = { inherit shellAliases; };

  };
}

