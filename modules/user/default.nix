# ==========================================================================
# Home Manager - Home.nix Imports
# ==========================================================================  

{ 
  hostName,
  lib,
  ... 
}: 

{ 
  imports = [

    # Core modules shared between all hosts, using /modules/user & default.nix for imports format.
    ./packages/git
    ./packages/kde
    ./packages/protonpass
    ./packages/system
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
    ./packages/localllama/desktop
    ./packages/mcp
    ./shell/nushell
    ./shell/tmux
    ./storage/rclone/desktop
 
  ]

  # Laptop-specific modules
  ++ lib.optionals (hostName == "nixpgadmin") [

    ./packages/localllama/laptop
    ./storage/rclone/laptop
    
  ];
}
