# ==========================================================================
# Podman Container Runtime
# ==========================================================================

{ 
  pkgs,  
  ... 
}:

{

  environment.systemPackages = with pkgs; [
    distrobox
    distroshelf
    podman
    podman-compose
    podman-desktop
    pods
  ];

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
    "docker.io"     # Docker Container Registry
    "ghcr.io"       # Github Container Registry
    "lscr.io"       # Linux Server Container Registry
    "quay.io"       # Quay Container Registry
  ];

  # Pass NVIDIA GPU to containers
  hardware.nvidia-container-toolkit.enable = true;

}