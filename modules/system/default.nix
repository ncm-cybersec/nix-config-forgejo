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
      ./packages/podman
      ./packages/scripts
      ./packages/system
      ./shell
      
    ]
        
    # Desktop-specific modules
    ++ lib.optionals (hostName == "nixadmin") [
      
      ./packages/localllama/desktop
      ./packages/security
      
    ]
    
    # Laptop-specific modules - will be adding these shortly!
    ++ lib.optionals (hostName == "nixpgadmin") [
      
      ./packages/localllama/laptop
      
    ];
}
