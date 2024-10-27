{ config, pkgs, lib, ... }: {
  home = { packages = with pkgs; [ oh-my-posh ]; };

  programs.zsh.initExtra = ''
    eval "${
      lib.getExe pkgs.oh-my-posh
    } init zsh --config ${config.xdg.configHome}/oh-my-posh/config.toml"
  '';

  home.file = {
    oh-my-posh = {
      enable = true;
      source = ./config.toml;
      target = ".config/oh-my-posh/config.toml";
    };
  };
}
