FROM nixos/nix

WORKDIR /app

COPY iso.nix build.sh ./

ENV SSH_KEY=""
ENV NIX_VERSION="25.05"

CMD [ "sh", "build.sh" ] 
