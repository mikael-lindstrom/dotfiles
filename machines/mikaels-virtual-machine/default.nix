{ inputs, user, system, pkgs, unstable-pkgs, src }:

let
  hostname = "Mikaels-Virtual-Machine";
in
inputs.darwin.lib.darwinSystem {
  inherit system;
  specialArgs = {
    inherit system user src pkgs unstable-pkgs hostname;
    inherit (inputs) home-manager nix-homebrew homebrew-core homebrew-bundle homebrew-cask neovim-flake opencode-flake;
  };
  modules = [
    ../../modules/nix-homebrew
    ../../modules/darwin
    ../../modules/home-manager/default.nix
  ];
}
