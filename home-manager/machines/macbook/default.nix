# The home manager configuration specific to my macbook
{ inputs, outputs, vars, lib, config, pkgs, ... }: {
  home = {
    packages = with pkgs; [
      nh
      ansible
      # (python312.withPackages (python-pkgs: [ python-pkgs.jmespath ]))
    ];
    username = vars.user;
    homeDirectory = vars.homeDir;
  };
}
