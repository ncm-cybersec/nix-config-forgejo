# ==========================================================================
# Home Manager Default Module
# ==========================================================================  

{ ... }: {
  imports = [
    ./kdepackages
    ./llmagents
    ./mcp
    ./shell/bash
    ./shell/nushell
    ./shell/tmux
    ./shell/zsh
    ./utilities/git
    ./utilities/rclone
    ./utilities/vicinae
  ];
}
