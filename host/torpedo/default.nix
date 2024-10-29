{ inputs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-12th-gen
    ../_common/global
    ../_common/user/toffer.nix

    ../_common/optional/greetd.nix
    ../_common/optional/sound.nix
    ../common/optional/bluetooth.nix
    ../_common/optional/docker.nix

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

  powerManagement.powertop.enable = true;
  programs = {
    light.enable = true;
    adb.enable = true;
    dconf.enable = true;
  };

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  security.sudo.wheelNeedsPassword = false;

  networking = { hostName = "torpedo"; };

  system.stateVersion = "24.05";
}
