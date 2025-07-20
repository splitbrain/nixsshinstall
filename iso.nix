{ config, pkgs, lib, ... }:
let
  sshKey = builtins.getEnv "SSH_KEY";
in
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  users.users.nixos.openssh.authorizedKeys.keys = lib.optional (sshKey != "") sshKey;

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
  isoImage.forceTextMode = true;

  environment.systemPackages = with pkgs; [
    wget
    curl
  ];

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
}
