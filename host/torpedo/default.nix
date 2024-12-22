{ inputs, pkgs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-12th-gen
    ../_common/global
    ../_common/user/toffer/nixos.nix

    ../_common/optional/greetd.nix
    ../_common/optional/sound.nix
    ../_common/optional/bluetooth.nix
    ../_common/optional/docker.nix
    ../_common/optional/vms.nix

    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

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

  environment.systemPackages =
    [ inputs.zen-browser.packages.x86_64-linux.specific ];

  system.stateVersion = "24.05";
}
