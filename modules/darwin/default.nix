{ user, pkgs, ... }:

{
  imports = [ ./homebrew.nix ];

  # Add homebrew to the system path
  environment.systemPath = [ "/opt/homebrew/bin" "/opt/homebrew/sbin" ];

  # Install only JetBrainsMono
  fonts.packages = [
    (pkgs.nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })
  ];

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
      extra-nix-path = "nixpkgs=flake:nixpkgs";
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };

  system.defaults.screencapture.location = "/Users/${user}/Documents/Screenshots";
  system.defaults.finder.FXPreferredViewStyle = "Nlsv";
  system.defaults.finder.ShowStatusBar = true;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;

  # Currently needs to be set https://github.com/LnL7/nix-darwin/issues/682
  users.users.${user}.home = "/Users/${user}";

  system.stateVersion = 4;
}
