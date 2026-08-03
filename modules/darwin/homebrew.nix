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

    casks = [
      "1password"
      "google-chrome"
      "discord"
      "docker-desktop"
      "elgato-control-center"
      "elgato-wave-link"
      "ghostty"
      "kitlangton-hex"
      "multipass"
      "raycast"
      "rectangle"
      "signal"
      "slack"
      "steam"
      "spotify"
      "utm"
      "vlc"
    ];
  };
}
