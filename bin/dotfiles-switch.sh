#!/usr/bin/env bash

set -euo pipefail

sudo darwin-rebuild switch --flake .#$(scutil --get LocalHostName)
