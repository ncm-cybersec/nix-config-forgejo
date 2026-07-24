# ==========================================================================
# Home Manager - Home.nix Imports
# ==========================================================================  

{ 
  hostName,
  lib,
  ... 
}: 

{ 
  
  # Core modules shared between all hosts
  imports = [
    ./packages/git
    ./packages/kde
    ./packages/localllama/aichat
    ./packages/protonpass
    ./packages/system
    ./packages/vicinae
    ./shell/bash
    ./shell/zsh
    ./sops
    ./storage/rclone
    ./theme
  ] 
  
  # Desktop-specific modules
  ++ lib.optionals (hostName == "nixadmin") [
    ./packages/localllama/llmagents
    ./shell/nushell
    ./shell/tmux
  ]

  # Laptop-specific modules
  ++ lib.optionals (hostName == "nixpgadmin") [

  ];
}
