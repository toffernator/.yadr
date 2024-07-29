{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Utils
    jq
    tldr
    ffmpeg
    devenv
    rHttp
    httpie

    # Git
    gh
    lazygit

    # Apps
    alacritty
  ];
}

