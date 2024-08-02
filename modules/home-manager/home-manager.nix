{ src, config, pkgs, unstable-pkgs, ... }:

let
  configDir = "${src}/config";
in
{
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.alacritty
    pkgs.argocd
    pkgs.aws-vault
    pkgs.awscli
    pkgs.cargo
    pkgs.devbox
    pkgs.gh
    pkgs.git
    pkgs.go
    unstable-pkgs.neovim
    pkgs.nodejs
    pkgs.rectangle
    pkgs.ripgrep
    pkgs.xq
  ];

  home.file = { };


  xdg.enable = true;
  xdg.configFile = {
    "alacritty".source = "${configDir}/alacritty";
    "nix".source = "${configDir}/nix";
    "starship.toml".source = "${configDir}/starship.toml";
    "tmux/tmux.conf".source = "${configDir}/tmux/tmux.conf";

    # Special case since nvim directory needs to be writable to install plugins
    "nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/src/github.com/mikael-lindstrom/dotfiles/config/nvim";
  };

  home.sessionVariables = {
    AWS_VAULT_PROMPT = "ykman";
    EDITOR = "nvim";
  };

  home.shellAliases = {
    "cat" = "bat";
    "dotfiles-update" = "darwin-rebuild switch --flake /Users/mikael/code/src/github.com/mikael-lindstrom/dotfiles/";
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

  programs.bat = {
    enable = true;
    config.theme = "gruvbox-dark";
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
