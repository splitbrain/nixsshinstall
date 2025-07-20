#!/bin/sh
set -e

if [ -z "$SSH_KEY" ]; then
    echo "ERROR: SSH_KEY environment variable is required but not set"
    exit 1
fi

echo "Using SSH_KEY: ${SSH_KEY}"


export NIX_PATH=nixos-config=$PWD/iso.nix:nixpkgs=channel:nixos-$NIX_VERSION
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage

mkdir -p /iso
cp result/iso/* /iso
ls -la /iso/
