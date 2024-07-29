{ config, lib, pkgs, ... }:

let
  shellAliases = {
    cd = "z";
    cdi = "zi";
  };
in {
  imports = [ ];
  options = {
    zoxide.enable = lib.mkEnableOption (lib.mdDoc "zoxide; a smarter cd");
  };
  config = lib.mkIf (config.zoxide.enable) {
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

