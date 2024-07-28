{ config, inputs, lib, pkgs, ... }: {
  nix = {
    gc = {
      # Intentionally empty because nh handles gc
      # TODO: Figure out gcing options
    };
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      # Allow devenv to manage caches for these users
      # TODO: Find a way to move this configuration to home/toffer
      trusted-users = [ "root" ] ++ [ "toffer" ];
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; }))
    ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

}
