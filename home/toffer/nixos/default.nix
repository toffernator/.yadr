{ ... }: {
  imports = [ ../part ];

  programs = import ./programs.nix;
  home.packages = import ./packages.nix;

  sway.enable = true;
}

