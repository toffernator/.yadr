# System-level configuration shared across all darwin systems.
{ inputs, outputs, var, lib, config, pkgs, ... }:

{
  nix.gc.interval = {
    Hour = 9;
    Minute = 0;
  };

  homebrew.casks.enable = true;
}
