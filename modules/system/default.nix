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
    
    # Core modules shared between all hosts, using /modules/system & default.nix for imports format.
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
  
  # To ensure that specific modules are loaded for each host, a conditional list based on config.networking.hostName is used with lib.optionals to only include the path if the hostname matches.
  
  # Desktop-specific modules
  ++ lib.optionals (config.networking.hostName == "nixadmin") [
    ./services/syncthing
  
  ]

  # Laptop-specific modules - will be adding these shortly!
  ++ lib.optionals (config.networking.hostName == "nixpgadmin") [

  ];
}
