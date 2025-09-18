{ system, user, src, pkgs, unstable-pkgs, home-manager, neovim-flake, opencode-flake, hostname, ... }:

{
  imports = [ home-manager.darwinModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit system src pkgs unstable-pkgs neovim-flake opencode-flake;
    };
    users.${user}.imports = [ ./home-manager.nix ];
  };
}
