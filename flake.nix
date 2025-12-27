# vim: expandtab sw=2

{
  description = "My nix-darwin and home-manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs, nixvim }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#aru-mbp13
    darwinConfigurations."aru-mbp13" = nix-darwin.lib.darwinSystem {
      modules = [
        nixvim.nixDarwinModules.nixvim {
          programs.nixvim.imports = [ ./nixvim.nix ];
        }
        ./configuration.nix
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.aru = ./home.nix;
        }
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
