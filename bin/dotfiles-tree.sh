#!/usr/bin/env bash

set -euo pipefail

nix run nixpkgs#nix-tree -- ./result
