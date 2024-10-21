{ inputs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-12th-gen
    ../_common/global
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  security.sudo.wheelNeedsPassword = false;

  networking = { hostName = "torpedo"; };

  system.stateVersion = "24.05";
}
