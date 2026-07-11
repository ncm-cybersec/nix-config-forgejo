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
      ./hardware
      ./networking
      ./packages/flatpak
      ./packages/podman
      ./packages/scripts
      ./packages/system
      ./shell
      
    ]
        
    # Desktop-specific modules
    ++ lib.optionals (hostName == "nixadmin") [
      
      ./packages/localllama/desktop
      
    ]
    
    # Laptop-specific modules
    ++ lib.optionals (hostName == "nixpgadmin") [
      
      ./packages/localllama/laptop
      
    ];
}
