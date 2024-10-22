{ ... }: {
  imports = [
    ./console.nix
    ./environment.nix
    ./i18n.nix
    ./networking.nix
    ./nix.nix
    ./nixpkgs.nix
    ./security.nix
    ./upower.nix
    ./zsh.nix
  ];
}
