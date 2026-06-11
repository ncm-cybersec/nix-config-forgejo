# ==========================================================================
# Home Manager - Home.nix Imports
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
    ./sops
    ./utilities/git
    ./utilities/protonpass
    ./utilities/rclone
    ./utilities/vicinae
  ];
}
