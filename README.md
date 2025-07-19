# NixOS Installer ISO with SSH Builder

Simple docker container to build a NixOS install image with SSH access pre-configured. Useful if you want to install NixOS headless.

It's the same as the standard minimal image, but SSH is started and your key will be authorized for the `nixos` user.


## Usage

```bash
docker run --rm -e SSH_KEY="$(cat ~/.ssh/id_rsa.pub)" -v $(pwd)/iso:/iso ghcr.io/splitbrain/nixsshinstall:main
```

The resulting ISO will be in the `iso` dir and can be "burned" to an USB drive.
