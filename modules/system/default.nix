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
      ./packages/appimage
      ./packages/flatpak
      ./packages/system
      ./scripts
      ./shell
      ./utilities/localllama
      ./utilities/podman
    ]
        
    # Desktop-specific modules
    ++ lib.optionals (hostName == "nixadmin") [
      
    ]
    
    # Laptop-specific modules
    ++ lib.optionals (hostName == "nixpgadmin") [

    ];
}
