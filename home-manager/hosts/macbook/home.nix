# The home manager configuration specific to my macbook
{ inputs, outputs, vars, lib, config, pkgs, ... }: {
  home = {
    username = vars.user;
    homeDirectory = vars.homeDir;
  };
}
