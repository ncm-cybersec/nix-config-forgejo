# ==========================================================================
# Nixos - Configuration.nix Imports
# ==========================================================================

{ 
  hostName,
  lib,
  ... 
}: 


{
  imports = [
    
    # Core modules shared between all hosts
    ./cache
    ./hardware
    ./networking
    ./packages/flatpak
    ./packages/localllama
    ./packages/podman
    ./packages/scripts
    ./packages/system
    ./shell
    ./sops
  
  ] 
  
  # Conditional list based on config.networking.hostName used with lib.optionals to only include path if hostname matches
  
  # Desktop-specific modules
  ++ lib.optionals (hostName == "nixadmin") [
    
    ./packages/security
    ./storage/syncthing/desktop
  
  ]

  # Laptop-specific modules - will be adding these shortly!
  ++ lib.optionals (hostName == "nixpgadmin") [

    ./storage/syncthing/laptop

  ];
}
