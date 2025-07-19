{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.machineIso = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ({ pkgs, ... }: {
          users.users.nixos.openssh.authorizedKeys.keys = 
            let sshKey = builtins.getEnv "SSH_KEY";
            in if sshKey != "" then [ sshKey ] else [];

          systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

          isoImage.squashfsCompression = "gzip -Xcompression-level 1";
        })
      ];
    };
  };
}
