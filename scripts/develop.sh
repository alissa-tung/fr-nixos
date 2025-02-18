#!/usr/bin/env bash
set -eu -o pipefail

nix --experimental-features 'nix-command flakes' develop
