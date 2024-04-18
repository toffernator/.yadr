{ config, lib, pkgs, ... }:

with lib; {
  imports = [ ];
  options = { zoxide.enable = mkEnableOption (mdDoc "zoxide; a smarter cd"); };
  config = mkIf (config.zoxide.enable) {
    home.packages = with pkgs; [ fzf ];

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    programs.bash = {
      # bashrcExtra = ''eval "$(zoxide init bash)"'';
      shellAliases = {
        cd = "z";
        cdi = "zi";
      };
    };

    programs.zsh = {
      shellAliases = {
        cd = "z";
        cdi = "zi";
      };
    };
  };
}

