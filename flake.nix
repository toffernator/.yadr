{
  description = "Your new nix config";

  inputs = {
    # Unstable just means rolling
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'stable-packages' overlay at 'overlays/default.nix'.
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: Consider:
    # hardware.url = "github:nixos/nixos-hardware";
    # nix-colors.url = "github:misterio77/nix-colors";
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
      nixosConfigurations = {
        torpedo = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./host/torpedo.nix ];
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
          modules = [ ./host/whackbook.nix ];
        };
      };
    };
}
