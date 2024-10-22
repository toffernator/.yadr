{ config, ... }: {
  programs.fzf = {
    enable = true;
    defaultOptions = [ "--color 16" ];
    enableZshIntegration = config.programs.zsh.enable;
  };
}
