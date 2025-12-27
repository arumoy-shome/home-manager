
# Installation
1. Install nix using Determinate Systems installer
1. Install nix-darwin
  + TODO: figure out how to scale this configuration across multiple devices
  + install homebrew
1. Install home-manager

# Karabiner Elements
- I use the *Modern Space Cadet (Rev 3)* rules for space cadet shifts and smart caps lock.

# Notes

## On managing homebrew using nix-darwin
+ I did not have luck trying to manager homebrew using nix-darwin
+ although the `homebrew.brewPrefix` option should correctly set the path to find the `brew` prefix, this does not work
+ I suspect it is because I am using the Determinate Systems version of nix (not upstream)
+ The trade-offs in terms of functionality is minimal for me and Determinate Systems is dropping support for upstream nix in their installer starting January 2026 anyway.

## nix store maintenance commands
+ run `nix-collect-garbage -d` to remove unused packages
+ run `nix-store --optimise` for further optimizations however this command takes a while to run

