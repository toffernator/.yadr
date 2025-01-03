{
  description = "toffernator's system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    sops-nix.url = "github:Mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";

    templ.url = "github:a-h/templ";
    zen-browser = { url = "github:0xc000022070/zen-browser-flake"; };

    ghostty = { url = "github:ghostty-org/ghostty"; };
  };

  outputs =
    { self, nixpkgs, home-manager, darwin, ghostty, zen-browser, ... }@inputs:
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
      overlays = { };

      templates = {
        python = {
          poetry = {
            path = ./templates/python/poetry;
            description =
              "Python development environment with Poetry, Ruff, and Pre-commit";
          };
          venv = {
            path = ./templates/python/venv;
            description =
              "Python development environment with a Python virtual environment and Pip";
          };
          spark = {
            path = ./templates/python/spark;
            description =
              "Python development environment with a Python virtual environment configured for use with Spark";
          };
        };
      };

      nixosConfigurations = {
        torpedo = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./host/torpedo
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.toffer = import ./home/toffer/torpedo.nix;
            }
          ];
        };
        lappietoppieIso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./host/lappietoppie/iso.nix ];
        };
      };
      darwinConfigurations = {
        whackbook = darwin.lib.darwinSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./host/whackbook
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.toffer = import ./home/toffer/whackbook.nix;
            }
          ];
        };
      };
    };
}
