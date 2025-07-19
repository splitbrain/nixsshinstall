FROM nixos/nix

WORKDIR /app

COPY flake.nix build.sh ./
COPY nix.conf /etc/nix/nix.conf

ENV SSH_KEY=""

CMD [ "sh", "build.sh" ] 
