{ ... }: {
  imports = [ ../part ./programs.nix ./packages.nix ];

  zsh.enable = true;
  alacritty.enable = true;
  git.enable = true;
  neovim.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
