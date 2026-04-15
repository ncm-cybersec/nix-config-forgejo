# ---------------------------------------------------
# Nixos System Services
# ---------------------------------------------------

{ config, pkgs, pkgsUnstable, ... }:

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

  # Enable Flatpak
  services.flatpak.enable = true;

  # Required to install flatpak
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "kde"
        ];
      };
    };
  };

  # Enable OpenRGB udev
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };

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
