{ user, pkgs, ... }:

{
  imports = [ ./homebrew.nix ];

  # Install only JetBrainsMono
  fonts.packages = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  # Enable zsh with nix-darwin
  programs.zsh.enable = true;

  # Enable daemon service
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    settings = {
      keep-derivations = true;
      keep-outputs = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };

  # Currently needs to be set https://github.com/LnL7/nix-darwin/issues/682
  users.users.${user}.home = "/Users/${user}";

  system.stateVersion = 4;
}
