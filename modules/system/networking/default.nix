# ==========================================================================
# Network Services Configuration
# ==========================================================================

{ 
  ... 
}:

{

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Enable Avahi/mDNS
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
  
  # Enable OpenSSH
  services.openssh = { 
    enable = true;
  };
  
  # Enable Tailscale 
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
    interfaceName = "tailscale0";
  };

  # Opnsense Tailscale Interface
  networking.firewall.trustedInterfaces = [
    "tailscale0"
  ];
  
  # TCP Ports and Ranges
  networking.firewall = {
    allowedTCPPorts = [
      8384           # Syncthing
      9300           # Packet / Quick Share
      24800          # Input-Leap
      53317          # Localsend
    ];
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;   # TCP range for KDEConnect
      }
    ];
  };

  # UDP Ports and Ranges
  networking.firewall = {
    allowedUDPPorts = [
      5353           # Avahi / MDNS, enabled by services.avahi ^
      41641          # Tailscale
      53317          # Localsend
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;   # UDP range for KDEConnect
      }
    ];
  };

}
