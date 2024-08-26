{ system, user, src, unstable-pkgs, home-manager, neovim-flake, ... }:

{
  imports = [ home-manager.darwinModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit system src unstable-pkgs neovim-flake;
    };
    users.${user}.imports = [ ./home-manager.nix ];
  };
}
