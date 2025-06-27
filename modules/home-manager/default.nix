{ system, user, src, unstable-pkgs, home-manager, neovim-flake, opencode-flake, ... }:

{
  imports = [ home-manager.darwinModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit system src unstable-pkgs neovim-flake opencode-flake;
    };
    users.${user}.imports = [ ./home-manager.nix ];
  };
}
