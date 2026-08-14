# ==========================================================================
# Podman Container Runtime
# ==========================================================================

{ 
  pkgs,  
  ... 
}:

{

  environment.systemPackages = with pkgs; [
    distrobox
    distroshelf
    podman
    podman-compose
    podman-desktop
    pods
  ];

  # Podman virtualisation
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
      
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };
}
