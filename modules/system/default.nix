# ---------------------------------------------------
# Nixos Conf.nix Imports
# ---------------------------------------------------

{ ... }: {
  imports = [
    ./boot
    ./graphics
    ./hardware
    ./networking
    ./packages
    ./services
  ];
}
