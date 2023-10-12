{ config, lib, pkgs, unstable, vars, ...}:

{
  config = lib.mkIf (config.rstudio.enable) {
    environment.systemPackages = with unstable; [
        rstudio
    ];
  };
}
