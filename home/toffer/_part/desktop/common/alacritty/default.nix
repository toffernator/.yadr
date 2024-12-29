{
  programs.alacritty.enable = true;

  home.file = {
    "alacritty" = {
      enable = true;
      source = ./alacritty.toml;
      target = ".config/alacritty/alacritty.toml";
    };

    "alacritty-themes" = {
      enable = true;
      source = ./themes;
      target = ".config/alacritty/themes";
    };
  };
}
