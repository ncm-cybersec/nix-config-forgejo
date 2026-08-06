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
    ./packages/kde
    ./packages/system
    ./shell/bash
    ./shell/zsh
    ./sops
    ./storage/rclone
    ./theme
    ./utilities/git
    ./utilities/kitty
    ./utilities/localllama/aichat
    ./utilities/protonpass
    ./utilities/vicinae
  ] 
  
  # Desktop-specific modules
  ++ lib.optionals (hostName == "nixadmin") [
    ./shell/nushell
    ./shell/tmux
    ./utilities/localllama/llmagents
  ]

  # Laptop-specific modules
  ++ lib.optionals (hostName == "nixpgadmin") [

  ];
}
