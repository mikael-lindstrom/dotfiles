{
  description = "Home Manager configuration of mikael";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    neovim-flake.url = "github:mikael-lindstrom/neovim-flake";
  };

  outputs = inputs@{ self, ... }:
    let
      user = "mikael";
      system = "aarch64-darwin";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      unstable-pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
      src = self;

      mkDarwinSystem = hostname:
        inputs.darwin.lib.darwinSystem {
          inherit system pkgs;
          specialArgs = {
            inherit system user src unstable-pkgs;
            inherit (inputs) home-manager nix-homebrew homebrew-core homebrew-bundle homebrew-cask neovim-flake;
          };
          modules = [
            ./modules/nix-homebrew
            ./modules/darwin
            ./modules/home-manager/default.nix
          ];
        };
    in
    {
      formatter.aarch64-darwin = pkgs.nixpkgs-fmt;

      darwinConfigurations = {
        "Mikaels-MacBook-Pro" = mkDarwinSystem "Mikaels-MacBook-Pro";
        "Mikael-Aidn" = mkDarwinSystem "Mikael-Aidn";
        "Mikaels-Virtual-Machine" = mkDarwinSystem "Mikaels-Virtual-Machine";
      };
    };
}
