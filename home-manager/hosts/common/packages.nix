{ pkgs, ... }:

let
  packages = with pkgs; [ ];
  packagesUnstable = with pkgs.unstable; [
    # Utils
    jq
    tldr

    # Git
    gh
    lazygit
  ];
in {
  imports = [ ];
  config = { home.packages = packages ++ packagesUnstable; };
}

