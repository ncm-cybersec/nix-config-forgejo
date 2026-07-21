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
    ./packages/localllama/aichat
    ./packages/protonpass
    ./packages/system
    ./packages/vicinae
    ./shell/bash
    ./shell/zsh
    ./sops
    ./theme
  
  ] 
  
  # Desktop-specific modules
  ++ lib.optionals (hostName == "nixadmin") [

    ./packages/localllama/llmagents
    ./packages/localllama/mcp
    ./shell/nushell
    ./shell/tmux
    ./storage/desktop/rclone
 
  ]

  # Laptop-specific modules
  ++ lib.optionals (hostName == "nixpgadmin") [

    ./storage/laptop/rclone
    
  ];
}
