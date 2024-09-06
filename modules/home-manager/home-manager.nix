{ system, src, pkgs, unstable-pkgs, neovim-flake, ... }:

let
  configDir = "${src}/config";
in
{
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.argocd
    pkgs.aws-vault
    pkgs.awscli
    pkgs.azure-cli
    pkgs.cargo
    unstable-pkgs.devbox
    pkgs.gh
    pkgs.git
    pkgs.go
    pkgs.neofetch
    pkgs.ripgrep
    unstable-pkgs.teleport
    pkgs.tmux
    pkgs.xq
    neovim-flake.packages.${system}.default
  ];

  home.file = { };

  xdg.enable = true;
  xdg.configFile = {
    "alacritty".source = "${configDir}/alacritty";
    "nix".source = "${configDir}/nix";
    "starship.toml".source = "${configDir}/starship.toml";
  };

  home.sessionVariables = {
    AWS_VAULT_PROMPT = "ykman";
    EDITOR = "nvim";
  };

  home.shellAliases = {
    "cat" = "bat";
    "dotfiles-build" = "pushd /Users/mikael/code/src/github.com/mikael-lindstrom/dotfiles/; darwin-rebuild build --flake .#$(hostname -s); popd";
    "dotfiles-latest-diff" = "nix store diff-closures /nix/var/nix/profiles/system-*-link(om[2]) /nix/var/nix/profiles/system-*-link(om[1])";
    "dotfiles-switch" = "pushd /Users/mikael/code/src/github.com/mikael-lindstrom/dotfiles/; darwin-rebuild switch --flake .#$(hostname -s); popd";
    "dotfiles-update" = "pushd /Users/mikael/code/src/github.com/mikael-lindstrom/dotfiles/; nix flake update; dotfiles-latest-diff; popd";
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

  programs.tmux =
    {
      enable = true;
      terminal = "screen-256color";
      historyLimit = 10000;
      clock24 = true;
      mouse = true;
      prefix = "C-a";
      escapeTime = 10;
      extraConfig = ''
        set-option -sa terminal-features ",alacritty*:RGB"
        bind -r j resize-pane -D 5
        bind -r k resize-pane -U 5
        bind -r l resize-pane -R 5
        bind -r h resize-pane -L 5
        bind -r m resize-pane -Z

        unbind %
        bind | split-window -h -c "#{pane_current_path}"

        unbind '"'
        bind - split-window -v -c "#{pane_current_path}"

        set -g status-position top
      '';
      plugins = [
        pkgs.tmuxPlugins.vim-tmux-navigator
        unstable-pkgs.tmuxPlugins.gruvbox
        pkgs.tmuxPlugins.resurrect
        {
          plugin = pkgs.tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '10'
          '';
        }
      ];
    };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
