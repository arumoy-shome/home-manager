# vim: expandtab sw=2

{ pkgs, ... }:
{
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
}
