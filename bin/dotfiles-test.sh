#!/usr/bin/env bash

set -euo pipefail

if [ "$(uname -s)" != "Linux" ] || [ ! -f /etc/NIXOS ]; then
  echo "Test activation is only supported on NixOS. Use dotfiles-build.sh for build-only checks on macOS." >&2
  exit 1
fi

host="${DOTFILES_HOST:-$(hostname -s)}"

echo "Building and test-activating ${host}; the boot default will not change." >&2
exec sudo nixos-rebuild test --flake ".#${host}" "$@"
