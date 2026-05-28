# ---------------------------------------------------
# Nixos Conf.nix Imports
# ---------------------------------------------------

{ ... }: {
  imports = [
    ./boot
    ./cache
    ./graphics
    ./hardware
    ./networking
    ./packages
    ./services/productivity
    ./services/system
    ./services/syncthing
    ./shell
  ];
}
