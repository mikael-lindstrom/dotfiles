{ pkgs, ... }:

{
  homebrew = {
    enable = true;

    # TODO: add more options for homebrew

    taps = [
      "homebrew/core"
      "homebrew/bundle"
      "homebrew/cask"
    ];

    brews = [
      "teleport" # latest version marked as broken in nix pkgs
    ];

    casks = [
      "1password"
      "discord"
      "docker"
      "elgato-control-center"
      "microsoft-remote-desktop"
      "signal"
      "slack"
      "spotify"
      "utm"
    ];
  };

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
