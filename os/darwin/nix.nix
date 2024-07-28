{ lib, ... }: {
  # Auto optimise store is broken on darwin:
  # https://github.com/NixOS/nix/issues/7273
  nix.settings.auto-optimise-store = lib.mkForce false;
}
