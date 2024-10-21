{ ... }: {
  imports = [
    ../_part/cli/git
    ../_part/cli/bat.nix
    ../_part/cli/zoxide.nix

    ../_parts/desktop/sway
  ];

  home = { stateVersion = "24.05"; };
}
