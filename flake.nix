{
  description = "Your new nix config";

  inputs = {
    # Unstable just means rolling
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'stable-packages' overlay at 'overlays/default.nix'.
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    templ.url = "github:a-h/templ";
  };

  outputs = { self, nixpkgs, darwin, ... }@inputs:
    let
      inherit (self) outputs;
      supported-systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supported-systems;
    in {
      packages =
        forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = {
        lappietoppie = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            vars = {
              os = "nixos";
              machine = "laptop";
              user = "toffer";
              homeDir = "/home/toffer";
            };
          };
          modules = [
            ./system/common.nix
            ./system/nixos.nix
            ./system/machine/laptop
            ./system/home.nix
          ];
        };
      };
      darwinConfigurations = {
        whackbook = darwin.lib.darwinSystem {
          specialArgs = {
            inherit inputs outputs;
            systemDetails = {
              os = "darwin";
              users = [ "toffer" ];
            };
          };
          modules = [
            ./system/common.nix
            ./system/darwin.nix
            ./system/machine/macbook
            ./system/home.nix
          ];
        };
      };
    };
}
