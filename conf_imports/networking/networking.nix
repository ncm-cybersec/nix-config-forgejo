# ---------------------------------------------------
# Networking Conf
# ---------------------------------------------------

{ config, pkgs, ... }:

{
  # System hostname
  networking.hostName = "nixadmin";

  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    9300  # Packet / Quick Share
    53317 # Localsend
  ];

  networking.firewall.allowedUDPPorts = [
    5353 # Avahi / MDNS, enabled by services.avahi ^
    53317 # Localsend
  ];

}
