#!/usr/bin/env bash

set -euo pipefail

nix flake update
dotfiles-build
dotfiles-latest-diff
