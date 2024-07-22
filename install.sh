#!/bin/bash

set -euo pipefail

install_nix() {
	if ! command -v "nix" >/dev/null; then
		echo "--- Installing nix ---"
		curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
		source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
	else
		echo "--- Nix is already installed ---"
	fi
}

install_home_manager() {
	echo "--- Installing home-manager ---"
	nix run home-manager/release-24.05 -- switch --flake /Users/mikael/code/src/github.com/mikael-lindstrom/dotfiles/
}

install_nix
install_home_manager
