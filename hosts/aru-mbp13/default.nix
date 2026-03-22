# vim: expandtab sw=2

{ user, ... }:

{
  networking.hostName = "aru-mbp13";
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.stateVersion = 6;
  system.primaryUser = user;

  users.users.${user} = {
    name = user;
    home = "/Users/${user}";
  };
}
