{ ... }: {
  imports = [ ../part ./packages.nix ./programs.nix ];

  sway.enable = true;
}

