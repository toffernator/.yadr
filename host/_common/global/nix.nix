{ inputs, lib, pkgs, ... }:
let flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
    gc = {
      # Intentionally empty, gc is handled by nh
    };

    # Add each flake input as a registry and nix_path
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      # Keep the last 3 generations
      extraArgs = "--delete-older-than +3";
    };
    flake = "/home/toffer/.yadr";
  };
}
