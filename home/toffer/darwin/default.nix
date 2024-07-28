{ ... }: {
  username = "toffer";
  homeDirectory = "/Users/toffer";

  programs = import ./programs.nix;
  home.packages = import ./packages.nix;
}
