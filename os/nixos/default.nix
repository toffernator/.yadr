{ ... }: {
  imports = [
    ./environment.nix
    ./fonts.nix
    ./internationalization.nix
    ./programs.nix
    ./services.nix
    ./users.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
