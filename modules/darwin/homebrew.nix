{ ... }:

{
  homebrew = {
    enable = true;

    global = {
      brewfile = true;
      autoUpdate = false;
    };

    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
    };

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
}
