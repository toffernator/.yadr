{ inputs, outputs, vars, lib, config, pkgs, ... }:

let
  modulePathPart =
    if vars.os == "nixos" then "nixosModules" else "darwinModules";
in {
  imports = [ inputs.home-manager."${modulePathPart}".home-manager ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs vars pkgs; };
    users."${vars.user}" = import ../home-manager/home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
