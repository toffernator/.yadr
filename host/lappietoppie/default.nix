{ ... }: {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./hardware-configuration.nix
    ./hardware.nix
    ./services.nix
  ];

  sway.enable = true;
}
