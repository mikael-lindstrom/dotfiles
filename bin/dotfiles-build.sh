#!/usr/bin/env bash

set -euo pipefail

case "$(uname -s)" in
  Darwin)
    host="${DOTFILES_HOST:-$(scutil --get LocalHostName)}"
    exec darwin-rebuild build --flake ".#${host}" "$@"
    ;;
  Linux)
    host="${DOTFILES_HOST:-$(hostname -s)}"
    exec nixos-rebuild build --flake ".#${host}" "$@"
    ;;
  *)
    echo "Unsupported operating system: $(uname -s)" >&2
    exit 1
    ;;
esac
