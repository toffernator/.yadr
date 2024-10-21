{ ... }: {
  imports = [
    ../_part/cli/git
    ../_part/cli/bat.nix
    ../_part/cli/zoxide.nix

    ../_part/desktop/sway
  ];

  home = { stateVersion = "24.05"; };
}
