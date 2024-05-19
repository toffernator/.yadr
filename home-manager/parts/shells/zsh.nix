{ config, lib, pkgs, ... }:

{
  imports = [ ../utilities ];

  options = { zsh.enable = lib.mkEnableOption (lib.mdDoc ""); };

  config = lib.mkIf (config.zsh.enable) {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ../../../dotfiles;
          file = ".p10k.zsh";
        }
      ];
    };

    bat.enable = true;
    zoxide.enable = true;
  };
}
