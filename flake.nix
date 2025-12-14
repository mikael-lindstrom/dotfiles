{
  description = "Home Manager configuration of mikael";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
    opencode-flake.url = "github:mikael-lindstrom/opencode-flake";
  };

  outputs = inputs@{ self, ... }:
    let
      user = "mikael";
      system = "aarch64-darwin";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      unstable-pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
      src = self;

    in
    {
      formatter.aarch64-darwin = pkgs.nixpkgs-fmt;

      darwinConfigurations = {
        "Mikaels-MacBook-Pro" = import ./machines/mikaels-macbook-pro { inherit inputs user system pkgs unstable-pkgs src; };
        "Mikael-Aidn" = import ./machines/mikael-aidn { inherit inputs user system pkgs unstable-pkgs src; };
        "Mikaels-Virtual-Machine" = import ./machines/mikaels-virtual-machine { inherit inputs user system pkgs unstable-pkgs src; };
      };
    };
}
