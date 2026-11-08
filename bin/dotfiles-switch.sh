#!/usr/bin/env bash

set -euo pipefail

case "$(uname -s)" in
  Darwin)
    host="${DOTFILES_HOST:-$(scutil --get LocalHostName)}"
    exec sudo darwin-rebuild switch --flake ".#${host}" "$@"
    ;;
  Linux)
    host="${DOTFILES_HOST:-$(hostname -s)}"
    exec sudo nixos-rebuild switch --flake ".#${host}" "$@"
    ;;
  *)
    echo "Unsupported operating system: $(uname -s)" >&2
    exit 1
    ;;
esac
