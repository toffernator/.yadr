# Configure kvm
# See more: https://nixos.wiki/wiki/Virt-manager

{ config, pkgs, vars, ... }: {
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # TODO: run on install `virsh net-start default`
}
