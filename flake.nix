{
  description = "Nix, NixOS System Flake Configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
      home-manager = {
        url = "github:nix-community/home-manager/release-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixgl = {
        # Fixes OpenGL With Other Distros.
        url = "github:guibou/nixGL";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      vars = {
        user = "toffer";
        terminal = "alacritty";
        editor = "nvim";
      };
    in
    {
      nixosConfigurations = (
        # NixOS Configurations
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager vars;
        }
      );

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
