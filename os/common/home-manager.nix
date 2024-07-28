{ inputs, outputs, systemDetails, pkgs, ... }:

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
    users = builtins.listToAttrs (builtins.map (user: {
      name = user;
      value = import "../home/${user}";
    }) systemDetails.users);
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
