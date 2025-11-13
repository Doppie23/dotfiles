#!/usr/bin/env bash
set -e

. ./.env

if [ -z "$1" ]; then
    echo "Error: system name argument required."
    echo "Usage: $0 <system-name>"
    exit 1
fi

SYSTEM_NAME="$1"

sudo \
    GIT_NAME="$GIT_NAME" \
    GIT_EMAIL="$GIT_EMAIL" \
    nixos-rebuild switch --flake ".#${SYSTEM_NAME}" --impure
