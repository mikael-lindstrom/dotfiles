{ pkgs, ... }:

{
  # Install only JetBrainsMono
  fonts.packages = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  # Enable zsh with nix-darwin
  programs.zsh.enable = true;

  # Auto upgrade nix package and enable daemon service
  nix.package = pkgs.nix;
  services.nix-daemon.enable = true;

  # Currently needs to be set https://github.com/LnL7/nix-darwin/issues/682
  users.users.mikael.home = "/Users/mikael";

  system.stateVersion = 4;
}
