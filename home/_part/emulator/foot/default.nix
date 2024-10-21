{ ... }: {
  programs.foot = { enable = true; };

  home.file = {
    foot = {
      enable = true;
      source = "foot.ini";
      target = ".config/foot/foot.ini";
    };
  };
}
