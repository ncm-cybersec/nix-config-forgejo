# ---------------------------------------------------
# Nixos Home.nix Imports
# ---------------------------------------------------

{ ... }: {
  imports = [
    ./kdepackages
    ./llmagents
    ./shell/bash
    ./shell/nushell
    ./shell/tmux
    ./shell/zsh
    ./utilities/git
    ./utilities/rclone
    ./utilities/vicinae
  ];
}
