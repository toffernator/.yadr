{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    # TODO: Consider:
    # nix-colors.url = "github:misterio77/nix-colors";
    templ.url = "github:a-h/templ";
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
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
        python-poetry = {
          path = ./templates/python/poetry;
          description =
            "Python development environment with Poetry, Ruff, and Pre-commit";
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
        torpedo = nixpkgs.lib.nixosSystem {
	  specialArgs = {
	    inherit inputs outputs;
	    vars = {
	      os = "nixos";
	      machine = "torpedo";
	      user = "toffer";
	      homeDir = "/home/toffer";
	    };
	  };
	  modules = [ 
            ./system/common.nix
            ./system/nixos.nix
            ./system/machine/torpedo
            ./system/home.nix
	  ];
        };
      };
      darwinConfigurations = {
        whackbook = darwin.lib.darwinSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./host/whackbook ];
        };
      };
    };
}
