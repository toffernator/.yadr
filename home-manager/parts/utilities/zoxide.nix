{ config, lib, pkgs, ... }:

with lib; {
  imports = [ ];
  options = { zoxide.enable = mkEnableOption (mdDoc "zoxide; a smarter cd"); };
  config = mkIf (config.zoxide.enable) {
    home.packages = with pkgs.unstable; [ zoxide fzf ];

    programs.bash = {
      bashrcExtra = ''eval "$(zoxide init bash)"'';
      shellAliases = {
        cd = "z";
        cdi = "zi";
      };
    };
  };
}

