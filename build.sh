#!/bin/sh
set -e

if [ -z "$SSH_KEY" ]; then
    echo "ERROR: SSH_KEY environment variable is required but not set"
    exit 1
fi

echo "Using SSH_KEY: ${SSH_KEY}"

# Build with SSH key using --impure to allow environment access
nix build --impure --expr "
  let
    flake = builtins.getFlake (toString ./.);
    sshKey = builtins.getEnv \"SSH_KEY\";
  in
    flake.packages.x86_64-linux.isoWithSshKey sshKey
"

mkdir -p /iso
cp result/iso/* /iso
ls -la /iso/
