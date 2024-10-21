{
  imports = [
    # Import your generated (nixos-generate-config) hardware configuration
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
