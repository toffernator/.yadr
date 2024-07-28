{ pkgs, ... }: {
  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    systemPackages = with pkgs; [
      coreutils
      git
      wget
      gzip
      vim

      wl-clipboard

      alsa-utils
      pipewire
      wireplumber
      pulseaudio
    ];
  };

  # This is necessary for zsh completion
  pathsToLink = [ "/share/zsh" ];
}
