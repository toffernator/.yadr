{ inputs, outputs, vars, lib, config, pkgs, ... }:

let
  nixosModulesOrDarwinModules =
    if vars.os == "nixos" then "nixosModules" else "darwinModules";
in {
  imports =
    [ inputs.home-manager."${nixosModulesOrDarwinModules}".home-manager ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs vars pkgs; };
    users."${vars.user}" = import ../home-manager;
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
