# ==========================================================================
# Home Manager - Home.nix Imports
# ==========================================================================  

{ 
  hostName,
  lib,
  pkgs,
  ... 
}: 

{ 
  imports = [

    # Core modules shared between all hosts, using /modules/user & default.nix for imports format.
    ./kdepackages
    ./shell/bash
    ./shell/zsh
    ./sops
    ./theme
    ./utilities/git
    ./utilities/protonpass
    ./utilities/vicinae
  
  ] 

  # To ensure that specific modules are loaded for each host, a conditional list based on config.networking.hostName is used with lib.optionals to only include the path if the hostname matches.
  
  # Desktop-specific modules
  ++ lib.optionals (hostName == "nixadmin") [
    ./llmagents
    ./mcp
    ./shell/nushell
    ./shell/tmux
    ./utilities/rclone

  ]

  # Laptop-specific modules - will be adding these shortly!
  ++ lib.optionals (hostName == "nixpgadmin") [
    
  ];
}
