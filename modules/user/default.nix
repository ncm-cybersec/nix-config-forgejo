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
