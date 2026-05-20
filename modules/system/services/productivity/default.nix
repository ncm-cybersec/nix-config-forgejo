# ---------------------------------------------------
# Nixos Productivity Services
# ---------------------------------------------------

{ config, pkgs, pkgsUnstable, ... }:

{
  # Enable Ollama for local llms
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    package = pkgsUnstable.ollama-cuda;
  };

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # Podman virtualisation
  virtualisation = {
  containers.enable = true;
  podman = {
    enable = true;
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