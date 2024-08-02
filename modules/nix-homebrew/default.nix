{ user, nix-homebrew, homebrew-core, homebrew-bundle, homebrew-cask, ... }:

{
  imports = [ nix-homebrew.darwinModules.nix-homebrew ];

  nix-homebrew = {
    inherit user;

    enable = true;
    enableRosetta = false;

    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-bundle" = homebrew-bundle;
      "homebrew/homebrew-cask" = homebrew-cask;
    };

    mutableTaps = false;
  };
}
