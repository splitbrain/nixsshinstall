{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: {
    # Function to build ISO with SSH key
    packages.x86_64-linux.isoWithSshKey = sshKey:
      if sshKey == "" then
        throw "SSH key cannot be empty"
      else
        (nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            ({ pkgs, ... }: {
              users.users.nixos.openssh.authorizedKeys.keys = [ sshKey ];

              systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

              isoImage.squashfsCompression = "gzip -Xcompression-level 1";
              isoImage.forceTextMode = true;
            })
          ];
        }).config.system.build.isoImage;
  };
}
