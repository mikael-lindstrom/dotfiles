#!/usr/bin/env bash

set -euo pipefail

darwin-rebuild build --flake .#$(scutil --get LocalHostName)
nix store diff-closures /run/current-system ./result
