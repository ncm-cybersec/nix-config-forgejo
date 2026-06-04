# ==========================================================================
# Nixos Productivity Services
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
    "docker.io"
    "quay.io"
    "ghcr.io"
  ];

  # Allow podman containers to utilize NVIDIA GPU
  hardware.nvidia-container-toolkit.enable = true;

}