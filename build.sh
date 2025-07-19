#!/bin/sh
set -e

echo "Using $SSH_KEY"

nix build .#nixosConfigurations.machineIso.config.system.build.isoImage
mkdir -p /iso
cp result/iso/* /iso
ls -la /iso/
