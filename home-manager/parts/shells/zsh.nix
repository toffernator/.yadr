{ config, lib, pkgs, ... }:

{
  imports = [ ../utilities ];

  options = { zsh.enable = lib.mkEnableOption (lib.mdDoc ""); };

  config = lib.mkIf (config.zsh.enable) {
    programs.zsh = {
      enable = true;
      # zprof.enable = true
      defaultKeymap = "viins";
      # Enable zsh completion. Don't forget to add `environment.pathsToLink = [ "/share/zsh" ];` 
      # to your system configuration to get completion for system packages (e.g. systemd.
      enableCompletion = true;

      history = {
        size = 5000;
        save = 5000;
        ignoreAllDups = false;
      };

      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;

      shellAliases = {
        ls = "ls --color";
        vim = "nvim";
      };

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

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    bat.enable = true;
    zoxide.enable = true;
  };
}
