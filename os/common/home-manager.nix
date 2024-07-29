{ inputs, outputs, systemDetails, pkgs, lib, ... }:

let
  nixosModulesOrDarwinModules =
    if systemDetails.os == "nixos" then "nixosModules" else "darwinModules";
in {
  imports =
    [ inputs.home-manager."${nixosModulesOrDarwinModules}".home-manager ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs pkgs;
      os = systemDetails.os;
    };

    backupFileExtension = "backup";

    # TODO: I want to use the below to couple each directory under home/ to the list of users passed in flake.nix.
    # However, it gives the error:
    # error: In module `/nix/store/nzyqy0p2y7hlc0m5nbfm8wgvjclrzw14-source/os/common/home-manager.nix', you're trying to 
    # define a value of type `lambda' rather than an attribute set for the option `home-manager.users.toffer'! This
    # usually happens if `home-manager.users.toffer' has option definitions inside that are not matched. Please check 
    # how to properly define this option by e.g. referring to `man 5 configuration.nix'!
    #
    # users = builtins.listToAttrs (builtins.map (user: {
    #   name = user;
    #   value = (import (../../home + "/${user}") {
    #     inherit lib;
    #     os = systemDetails.os;
    #   });
    # }) systemDetails.users);
    users = { toffer = import ../../home/toffer; };

    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
