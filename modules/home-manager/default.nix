{ user, src, unstable-pkgs, home-manager, ... }:

{
  imports = [ home-manager.darwinModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit src unstable-pkgs;
    };
    users.${user}.imports = [ ./home-manager.nix ];
  };
}
