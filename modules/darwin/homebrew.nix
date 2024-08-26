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
      "alacritty"
      "google-chrome"
      "discord"
      "docker"
      "elgato-control-center"
      "microsoft-remote-desktop"
      "multipass"
      "rectangle"
      "signal"
      "slack"
      "spotify"
      "utm"
    ];
  };
}
