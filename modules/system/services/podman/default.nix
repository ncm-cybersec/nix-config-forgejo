# ---------------------------------------------------
# Nixos Productivity Services
# ---------------------------------------------------

{ pkgs, pkgsUnstable, ... }:

{

  # Podman virtualisation
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      enableNvidia = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Podman container registries
  virtualisation.containers.registries.search = [
    "docker.io"
    "quay.io"
    "ghcr.io"
  ];

}