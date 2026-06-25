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
    ./packages/git
    ./packages/kde
    ./packages/protonpass
    ./packages/vicinae
    ./shell/bash
    ./shell/zsh
    ./sops
    ./theme
  
  ] 

  # To ensure that specific modules are loaded for each host, a conditional list based on config.networking.hostName is used with lib.optionals to only include the path if the hostname matches.
  
  # Desktop-specific modules
  ++ lib.optionals (hostName == "nixadmin") [

    ./packages/llmagents
    ./packages/mcp
    ./shell/nushell
    ./shell/tmux
    ./storage/rclone

  ]

  # Laptop-specific modules - will be adding these shortly!
  ++ lib.optionals (hostName == "nixpgadmin") [
    
  ];
}
