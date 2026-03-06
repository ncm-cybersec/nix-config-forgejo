# ---------------------------------------------------
# Nixos System Services
# ---------------------------------------------------

{ config, pkgs, ... }:

{
  # Enable Avahi/mDNS for network discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
      addresses = true;
    };
  };

  # Enable OpenRGB udev
  services.hardware.openrgb.enable = true;

  # Enable Ollama for local llms
  services.ollama = {
    enable = true;
    acceleration = "cuda";
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
