#!/usr/bin/env bash
set -e

. ./.env

sudo \
    GIT_NAME="$GIT_NAME" \
    GIT_EMAIL="$GIT_EMAIL" \
    nixos-rebuild switch --flake .#pc --impure
