# System-level configuration shared across all darwin systems.
{ inputs, outputs, lib, config, pkgs, ... }: {
  # Because of programs.zsh.enableCompletion in ../home-manager/macbook.nix
  environment.pathsToLink = [ "/share/zsh" ];

  nix.gc.interval = {
    Hour = 9;
    Minute = 0;
  };

  # Auto optimise store is broken on darwin:
  # https://github.com/NixOS/nix/issues/7273
  nix.settings.auto-optimise-store = lib.mkForce false;

  homebrew.casks.enable = true;
}
