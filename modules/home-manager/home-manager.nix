{ system, src, pkgs, unstable-pkgs, neovim-flake, ... }:

let
  configDir = "${src}/config";
in
{
  home.stateVersion = "24.11";

  home.packages = [
    pkgs.argocd
    pkgs.aws-vault
    pkgs.awscli
    (unstable-pkgs.azure-cli.withExtensions [ unstable-pkgs.azure-cli-extensions.bastion unstable-pkgs.azure-cli-extensions.ssh ])
    pkgs.cargo
    unstable-pkgs.devbox
    pkgs.gh
    pkgs.git
    pkgs.go
    pkgs.neofetch
    pkgs.ripgrep
    pkgs.tmux
    pkgs.xq
    neovim-flake.packages.${system}.default
  ];

  home.file = { };
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  xdg.enable = true;
  xdg.configFile = {
    "alacritty".source = "${configDir}/alacritty";
    "ghostty".source = "${configDir}/ghostty";
    "nix".source = "${configDir}/nix";
    "starship.toml".source = "${configDir}/starship.toml";
  };

  home.sessionVariables = {
    AWS_VAULT_PROMPT = "ykman";
    EDITOR = "nvim";
  };

  home.shellAliases = {
    "cat" = "bat";
    "dotfiles-build" = "cd /Users/mikael/code/src/github.com/mikael-lindstrom/dotfiles; darwin-rebuild build --flake .#$(scutil --get LocalHostName)";
    "dotfiles-latest-diff" = "nix store diff-closures /run/current-system ./result";
    "dotfiles-switch" = "cd /Users/mikael/code/src/github.com/mikael-lindstrom/dotfiles; darwin-rebuild switch --flake .#$(scutil --get LocalHostName)";
    "dotfiles-update" = "cd /Users/mikael/code/src/github.com/mikael-lindstrom/dotfiles; nix flake update; dotfiles-latest-diff";
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
        "azure"
        "git"
        "kubectl"
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
    # current stable version has a bug with fzf-history-widget and zsh
    package = unstable-pkgs.fzf;
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

        set-window-option -g mode-keys vi
        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

        set -g status-position top
        set -g default-command "$SHELL"
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
