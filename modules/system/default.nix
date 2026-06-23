# ==========================================================================
# Nixos Configuration.nix Imports
# ==========================================================================

{ ... }: {
  imports = [
    ./cache
    ./hardware
    ./networking
    ./packages/flatpak
    ./packages/scripts
    ./packages/system
    ./services/localllama
    ./services/podman
    ./services/syncthing
    ./shell
  ];
}
