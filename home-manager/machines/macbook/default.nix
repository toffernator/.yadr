# The home manager configuration specific to my macbook
{ inputs, outputs, vars, lib, config, pkgs, ... }: {
  home = {
    packages = with pkgs; [ nh jetbrains.clion ];
    username = vars.user;
    homeDirectory = vars.homeDir;
  };
}
