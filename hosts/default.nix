{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, vars, ... }:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in {
  laptop = lib.nixosSystem {
    # Laptop Profile
    inherit system;
    specialArgs = {
      inherit inputs unstable vars;
      host = { hostName = "lappietoppie"; };
    };
    modules = [
      ./laptop
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${vars.user} = import ../home-manager;
          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        };
      }
    ];
  };
}
