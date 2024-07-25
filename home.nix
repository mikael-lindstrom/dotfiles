{ config, pkgs, unstable-pkgs, ... }:

{
  home.username = "mikael";
  home.homeDirectory = "/Users/mikael";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.argocd
    pkgs.aws-vault
    pkgs.awscli
    pkgs.bat
    pkgs.cargo
    pkgs.devbox
    pkgs.gh
    pkgs.git
    pkgs.go
    unstable-pkgs.neovim
    pkgs.nodejs
    pkgs.ripgrep
    pkgs.xq
  ];

  home.file = { };

  xdg.enable = true;
  xdg.configFile = {
    "alacritty".source = ./config/alacritty;
    "nix".source = ./config/nix;
    "starship.toml".source = ./config/starship.toml;
    "tmux/tmux.conf".source = ./config/tmux/tmux.conf;

    # Special case since nvim directory needs to be writable to install plugins
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/src/github.com/mikael-lindstrom/dotfiles/config/nvim";
  };

  home.sessionVariables = {
    AWS_VAULT_PROMPT = "ykman";
    EDITOR = "nvim";
    BAT_THEME = "gruvbox-dark";
  };

  home.shellAliases = {
    "cat" = "bat";
    "dotfiles-update" = "home-manager switch --flake /Users/mikael/code/src/github.com/mikael-lindstrom/dotfiles/";
    "ll" = "ls -lh";
    "la" = "ls -lah";
    "vim" = "nvim";
  };

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "agnoster";
    };
  };

  programs.starship = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
