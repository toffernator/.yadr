{ lib, inputs, nixpkgs, nixpkgs-unstable, vars, ... }:

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
in
{
  laptop = lib.nixosSystem {
    # Laptop Profile
    inherit system;
    specialArgs = {
      inherit inputs unstable vars;
      host = {
        hostName = "lappietoppie";
      };
    };
    modules = [
      ./laptop
      ./configuration.nix
    ];
  };
}
