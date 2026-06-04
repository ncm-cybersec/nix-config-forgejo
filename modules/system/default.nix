# ==========================================================================
# Nixos Configuration.nix Imports
# ==========================================================================

{ ... }: {
  imports = [
    ./boot
    ./cache
    ./graphics
    ./hardware
    ./networking
    ./packages/flatpak
    ./packages/system
    ./services/localllama
    ./services/podman
    ./services/syncthing
    ./shell
  ];
}
