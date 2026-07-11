# ==========================================================================
# Network Services & Security Configuration
# ==========================================================================

{
  pkgs,
  ...
}: 

{
  environment.systemPackages = with pkgs; [
    
    # General
    cacert
    certinfo-go
    macchanger
    nfs-utils

    # Security & Monitoring
    aircrack-ng
    airgeddon
    arp-scan
    arp-scan-rs
    mdns-scanner
    netscanner
    netsniff-ng
    nmap
    suricata
    tailscale
    tail-tray
    wireshark
    wireshark-cli
    zeek
    zenmap
  ];

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Network Services
  services = {
    
    # Enable Avahi/mDNS
    avahi = {
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
    openssh = {
      enable = true;
    };

    # Enable Tailscale
    tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = "client";
      interfaceName = "tailscale0";
    }; 
  };

  # Firewall Configuration
  networking.firewall = {
    
    # OPNsense Tailscale Interface
    trustedInterfaces = [
      "tailscale0"
    ];
    
    # TCP Ports
    allowedTCPPorts = [
      3080  # LibreChat
      8033  # LLMhop WebUI
      8080  # LLMhop Proxy
      8384  # Syncthing
      9300  # Packet / Quick Share
      24800 # Input-Leap
      53317 # Localsend
    ];
    
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764; # TCP range for KDEConnect
      }
    ];
    
    # UDP Ports
    allowedUDPPorts = [
      5353  # Avahi / MDNS, enabled by services.avahi ^
      41641 # Tailscale
      53317 # Localsend
    ];
    
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;  # UDP range for KDEConnect
      }
    ];
  };
}
