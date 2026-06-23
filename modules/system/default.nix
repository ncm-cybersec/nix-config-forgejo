# ==========================================================================
# Nixos - Configuration.nix Imports
# ==========================================================================

{ 
  config,
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
  ++ lib.optionals (config.networking.hostName == "nixadmin") [
    ./services/syncthing
  
  ]

  # Laptop-specific modules - will be adding these shortly!
  ++ lib.optionals (config.networking.hostName == "nixpgadmin") [

  ];
}
