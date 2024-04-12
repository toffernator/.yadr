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
}
