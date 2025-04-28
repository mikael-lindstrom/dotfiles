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

  # Managed by determinate systems
  nix.enable = false;

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
  system.defaults.dock.autohide = true;
  system.defaults.dock.tilesize = 36;
  system.defaults.controlcenter.Bluetooth = true;
  system.defaults.controlcenter.Sound = true;

  # Currently needs to be set https://github.com/LnL7/nix-darwin/issues/682
  users.users.${user}.home = "/Users/${user}";

  system.stateVersion = 4;
}
