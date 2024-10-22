{ pkgs, ... }:

{
  imports = [ ];
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      package = pkgs.delta;
    };
  };

  home.file = {
    ".gitconfig" = {
      enable = true;
      source = ./.gitconfig;
      target = ".gitconfig";
    };
  };
}

