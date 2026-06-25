# ==========================================================================
# Nixos - Configuration.nix Imports
# ==========================================================================

{ 
  hostName,
  lib,
  pkgs,
  ... 
}: 


{
  imports = [
    
    # Core modules shared between all hosts
    ./cache
    ./hardware
    ./networking
    ./packages/flatpak
    ./packages/scripts
    ./packages/system
    ./services/localllama
    ./services/podman
    ./shell
  
  ] 
  
  # Conditional list based on config.networking.hostName used with lib.optionals to only include path if hostname matches
  
  # Desktop-specific modules
  ++ lib.optionals (hostName == "nixadmin") [
    
    ./packages/security
    ./services/syncthing
  
  ]

  # Laptop-specific modules - will be adding these shortly!
  ++ lib.optionals (hostName == "nixpgadmin") [


  ];
}
