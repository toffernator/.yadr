{
  description = "Your new nix config";

  inputs = {
    # Unstable just means rolling
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'stable-packages' overlay at 'overlays/default.nix'.
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    # TODO: Consider:
    # hardware.url = "github:nixos/nixos-hardware";
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs:
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

      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
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
        macbook = darwin.lib.darwinSystem {
          specialArgs = {
            inherit inputs outputs;
            vars = {
              os = "darwin";
              machine = "macbook";
              user = "toffer";
              homeDir = "/Users/toffer";
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
