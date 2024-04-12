{ config, pkgs, lib, ... }: {
  # NixOS wants to enable GRUB by default
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  # On other boards, pick a different kernel, note that on most boards with good mainline support, default, latest and hardened should all work
  # Others might need a BSP kernel, which should be noted in their respective wiki entries
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # nixos-generate-config should normally set up file systems correctly
  imports = [ ./hardware-configuration.nix ];

  # !!! Adding a swap file is optional, but recommended if you use RAM-intensive applications that might OOM otherwise. 
  # Size is in MiB, set to whatever you want (though note a larger value will use more disk space).
  # swapDevices = [ { device = "/swapfile"; size = 1024; } ];

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };

  # Apparently WiFi is broken on Raspberry Pi 3B+, I have a 3B but leaving this
  # here just in case
  systemd.services.iwd.serviceConfig.Restart = "always";
  hardware = {
    enableRedistributableFirmware = true;
    firmware = [ pkgs.wireless-regdb ];
  };
  networking = {
    useDHCP = false;
    interfaces.wlan0.useDHCP = true;
    networkmanager.wifi.backend = "iwd";
    wireless.iwd.enable = true;
  };
  boot = {
    extraModprobeConfig = ''
      options cfg80211 ieee80211_regdom="US"
    '';
  };

  system = { stateVersion = "23.11"; };
}
