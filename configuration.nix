{ pkgs, inputs, ... }:
{
  environment.enableAllTerminfo = true;
  environment.systemPackages =
    [];

  fonts.packages = [
    pkgs.nerd-fonts.sauce-code-pro
    pkgs.ia-writer-duospace
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
  system.primaryUser = "aru";

  security.pam.services.sudo_local.touchIdAuth = true;

  services.aerospace = {
    enable = true;
    settings = {
      default-root-container-layout = "accordion";
      default-root-container-orientation = "vertical";
      mode.main.binding = {
        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";
        alt-minus = "resize smart -50";
        alt-equal = "resize smart +50";
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-a = "workspace A";
        alt-b = "workspace B";
        alt-c = "workspace C";
        alt-f = "workspace F";
        alt-m = "workspace M";
        alt-p = "workspace P";
        alt-r = "workspace R";
        alt-s = "workspace S";
        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
      };
      on-window-detected = [
        {
          "if".app-id = "com.apple.iCal";
          run = [ "move-node-to-workspace C"];
        }
        {
          "if".app-id = "com.apple.finder";
          run = [ "move-node-to-workspace F"];
        }
        {
          "if".app-id = "com.apple.mail";
          run = [ "move-node-to-workspace S"];
        }
        {
          "if".app-id = "com.apple.MobileSMS";
          run = [ "move-node-to-workspace S"];
        }
        {
          "if".app-id = "blog.micro.mac";
          run = [ "move-node-to-workspace S"];
        }
        {
          "if".app-id = "com.apple.Notes";
          run = [ "move-node-to-workspace N"];
        }
        {
          "if".app-id = "com.apple.reminders";
          run = [ "move-node-to-workspace P"];
        }
        {
          "if".app-id = "org.zotero.zotero-beta";
          run = [ "move-node-to-workspace R"];
        }
        {
          "if".app-id = "net.kovidgoyal.kitty";
          run = [ "move-node-to-workspace 1"];
        }
        {
          "if".app-id = "com.kagi.kagimacOS";
          run = [ "move-node-to-workspace B"];
        }
        {
          "if".app-id = "com.spotify.client";
          run = [ "move-node-to-workspace M"];
        }
      ];
    };
  };

  programs.direnv.enable = true;

  users.users.aru = {
    name = "aru";
    home = "/Users/aru";
  };
}
