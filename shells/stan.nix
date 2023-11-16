# https://nixos.org/manual/nixpkgs/stable/#rstudio

{ pkgs ? import <nixpkgs> {} }:

pkgs.rstudioWrapper.override {
  packages = with pkgs.rPackages; [ dplyr ggplot2 reshape2 ];
}
