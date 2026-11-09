{ system, user, src, pkgs, lib, unstable-pkgs, home-manager, neovim-flake, hostname, ... }:

{
  imports = [
    (if lib.hasSuffix "-darwin" system then
      home-manager.darwinModules.home-manager
    else
      home-manager.nixosModules.home-manager)
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit system src pkgs unstable-pkgs neovim-flake;
    };
    users.${user}.imports = [ ./home-manager.nix ];
  };
}
