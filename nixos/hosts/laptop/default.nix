{ config, pkgs, host, vars, ... }:

{
  imports = [
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];
}
