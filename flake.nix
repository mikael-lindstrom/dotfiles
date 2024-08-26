{
  description = "Home Manager configuration of mikael";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
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

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nix-homebrew, homebrew-core, homebrew-bundle, homebrew-cask, neovim-flake, ... }@inputs:
    let
      user = "mikael";
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable-pkgs = nixpkgs-unstable.legacyPackages.${system};
      src = self;
    in
    {
      darwinConfigurations.Mikaels-MBP =
        inputs.darwin.lib.darwinSystem
          {
            inherit system pkgs;
            specialArgs =
              {
                inherit system user src unstable-pkgs home-manager nix-homebrew homebrew-core homebrew-bundle homebrew-cask neovim-flake;
              };
            modules = [
              ./modules/nix-homebrew
              ./modules/darwin
              ./modules/home-manager/default.nix
            ];
          };

      darwinConfigurations.Mikaels-Virtual-Machine =
        inputs.darwin.lib.darwinSystem
          {
            inherit system pkgs;
            specialArgs =
              {
                inherit system user src unstable-pkgs home-manager nix-homebrew homebrew-core homebrew-bundle homebrew-cask neovim-flake;
              };
            modules = [
              ./modules/nix-homebrew
              ./modules/darwin
              ./modules/home-manager/default.nix
            ];
          };
    };
}
