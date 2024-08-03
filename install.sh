#!/bin/bash

set -euo pipefail

DOTFILES_PATH="${HOME}/code/src/github.com/mikael-lindstrom/dotfiles"
DOTFILES_REPO="https://github.com/mikael-lindstrom/dotfiles.git"

install_xcode() {
	if ! xcode-select -p &>/dev/null; then
		echo "--- Installing xcode ---"
		xcode-select --install
	fi
}

clone_dotfiles() {
	if [ ! -d "${DOTFILES_PATH}" ]; then
		echo "--- Cloning repo ---"
		git clone "${DOTFILES_REPO}" "${DOTFILES_PATH}"
	fi
}

install_nix() {
	if ! command -v "nix" >/dev/null; then
		echo "--- Installing nix ---"
		curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
		source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
	else
		echo "--- Nix is already installed ---"
	fi
}

install_nix_darwin() {
	if ! command -v "darwin-rebuild" >/dev/null; then
		echo "--- Installing nix-darwin ---"
		set +u
		nix run --extra-experimental-features "nix-command flakes" nix-darwin -- switch --flake "${DOTFILES_PATH}"
		set -u
	else
		echo "--- nix-darwin already installed ---"
	fi
}

install_xcode
clone_dotfiles
install_nix
install_nix_darwin
