#!/usr/bin/env bash

set -euo pipefail

nix store diff-closures /run/current-system ./result
