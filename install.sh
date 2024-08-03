#!/bin/bash

set -euo pipefail

DOTFILES_PATH="${HOME}/code/src/github.com/mikael-lindstrom/dotfiles"
DOTFILES_REPO="https://github.com/mikael-lindstrom/dotfiles.git"
HOSTNAME="$(hostname -s)"

install_xcode() {
	if ! xcode-select -p &>/dev/null; then
		echo "--- Installing xcode ---"
		xcode-select --install
                exit 0
	else
		echo "--- Xcode already installed ---"
	fi
}

clone_dotfiles() {
	if [ ! -d "${DOTFILES_PATH}" ]; then
		echo "--- Cloning repo ---"
		git clone "${DOTFILES_REPO}" "${DOTFILES_PATH}"
	else
		echo "--- Repo already cloned ---"
	fi
}

install_nix() {
	if ! command -v "nix" >/dev/null; then
		echo "--- Installing nix ---"
		curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
		set +u
		source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
                set -u
	else
		echo "--- Nix is already installed ---"
	fi
}

install_nix_darwin() {
	if ! command -v "darwin-rebuild" >/dev/null; then
                if [ -f /etc/nix/nix.conf ]; then
                    echo "--- Moving /etc/nix/nix.conf to /etc/nix/nix.conf.before-nix-darwin ---"
                    sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
                fi
		echo "--- Installing nix-darwin ---"
		nix run --extra-experimental-features "nix-command flakes" nix-darwin -- switch --flake "${DOTFILES_PATH}#${HOSTNAME}"
	else
		echo "--- nix-darwin already installed ---"
	fi
}

echo "Installing dotfiles for $HOSTNAME"

install_xcode
clone_dotfiles
install_nix
install_nix_darwin
