{ pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
    # NVidia doesn't always play nice with linuxPackages_latest
    # https://discourse.nixos.org/t/nvidia-fails-to-build/34392/3
    #
    # Use the longterm version from https://kernel.org/, for which you can find
    # find the corresponding package with:
    # $ nix repl
    # nix-repl> :l <nixpkgs>
    # nix-repl> pkgs.linux_Packages_<TAB>
    kernelPackages = pkgs.linuxPackages_6_8;
  };
}
