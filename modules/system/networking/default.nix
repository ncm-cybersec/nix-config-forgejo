# ---------------------------------------------------
# Networking Configuration
# ---------------------------------------------------

{ config, pkgs, ... }:

{
  # System hostname
  networking.hostName = "nixadmin";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Tailscale
  services.tailscale.enable = true;

  # Opnsense Tailscale Interface
  networking.firewall.trustedInterfaces = [
    "tailscale0"
  ];
  
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    8384  # Syncthing
    9300  # Packet / Quick Share
    24800 # Input-Leap
    53317 # Localsend
  ];

  networking.firewall.allowedUDPPorts = [
    5353  # Avahi / MDNS, enabled by services.avahi ^
    41641 # Tailscale
    53317 # Localsend
  ];

}
