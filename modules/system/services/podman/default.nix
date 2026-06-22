# ==========================================================================
# Podman Container Runtime
# ==========================================================================

{ 
  pkgs, 
  pkgsUnstable, 
  ... 
}:

{

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

  # Allow podman containers to utilize NVIDIA GPU
  hardware.nvidia-container-toolkit.enable = true;

}