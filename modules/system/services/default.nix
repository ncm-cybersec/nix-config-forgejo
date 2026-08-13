# ==========================================================================
# System Services - Imports
# ==========================================================================

{
  hostName,
  lib,
  ...
}: 

{
  
  # Core modules shared between all hosts
  imports = [

    ]
        
    # Desktop-specific modules
    ++ lib.optionals (hostName == "nixadmin") [
      ./atuin-serv
    ]
    
    # Laptop-specific modules
    ++ lib.optionals (hostName == "nixpgadmin") [

    ];
}