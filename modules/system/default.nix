# ==========================================================================
# Nixos - Configuration.nix Imports
# ==========================================================================

{
  hostName,
  lib,
  ...
}: 

{
  
  # Core modules shared between all hosts
  imports = [
      ./hardware
      ./networking
      ./packages/flatpak
      ./packages/localllama
      ./packages/podman
      ./packages/scripts
      ./packages/system
      ./shell
    ]
        
    # Desktop-specific modules
    ++ lib.optionals (hostName == "nixadmin") [
      
      
    ]
    
    # Laptop-specific modules
    ++ lib.optionals (hostName == "nixpgadmin") [

            
    ];
}
