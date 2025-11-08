# vim: expandtab sw=2

{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, home-manager, nix-darwin, nixpkgs, nixvim }:
  let
    configuration = { pkgs, ... }: {
      environment.systemPackages =
        [];

      nix.settings.experimental-features = "nix-command flakes";
      nix.enable = false;

      nixpkgs.hostPlatform = "aarch64-darwin";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;
      system.primaryUser = "aru";

      security.pam.services.sudo_local.touchIdAuth = true;
      users.users.aru = {
        name = "aru";
        home = "/Users/aru";
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#aru-mbp13
    darwinConfigurations."aru-mbp13" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nixvim.nixDarwinModules.nixvim {
          programs.nixvim.imports = [ ./nixvim.nix ];
        }
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.aru = ./home.nix;
        }
      ];
    };
  };
}
