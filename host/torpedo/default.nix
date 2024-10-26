{ inputs, pkgs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-12th-gen
    ../_common/global
    ../_common/user/toffer.nix

    ../_common/optional/docker.nix
    ../_common/optional/sound.nix

    ./hardware-configuration.nix
  ];

  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
  };

  security.sudo.wheelNeedsPassword = false;

  networking = { hostName = "torpedo"; };

  system.stateVersion = "24.05";
}
