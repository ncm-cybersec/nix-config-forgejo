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
    ./utilities/git
    ./utilities/rclone
    ./utilities/vicinae
  ];
}
