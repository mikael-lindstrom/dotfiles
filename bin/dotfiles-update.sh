#!/usr/bin/env bash

set -euo pipefail

nix flake update
dotfiles-build.sh
dotfiles-latest-diff.sh
