{ inputs, user, src }:

let
  system = "x86_64-linux";
  hostname = "nuc";
  pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
in
inputs.nixpkgs-unstable.lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit system user src hostname;
    unstable-pkgs = pkgs;
    home-manager = inputs.home-manager-unstable;
    inherit (inputs) neovim-flake;
  };
  modules = [
    inputs.determinate.nixosModules.default
    ../../modules/nixos
    ../../modules/home-manager
    ./hardware-configuration.nix

    {
      networking.hostName = hostname;

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      services.tailscale = {
        enable = true;
        openFirewall = true;
      };

      users.users.${user}.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFYL0uzsYj0LjiY1XcMgXPMTHmSfw15jG4PdjBw+VJq7"
      ];

      # Preserve the version used for the initial installation.
      system.stateVersion = "26.11";
    }
  ];
}
