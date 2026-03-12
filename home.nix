# ---------------------------------------------------
# Nixos Home Manager Conf
# ---------------------------------------------------

{ config, inputs, pkgs, ... }:

{
  imports =
    [
      ./home_imports/home_packages/kdepackages.nix
      ./home_imports/home_packages/llmagents.nix
      ./home_imports/shell/bash/bash.nix
      ./home_imports/shell/nushell/nushell.nix
      ./home_imports/shell/tmux/tmux.nix
      ./home_imports/utilities/git/git.nix
      ./home_imports/utilities/rclone/rclone.nix
      ./home_imports/utilities/vicinae/vicinae.nix
    ];

  home = {
    username = "nixadmin";
    homeDirectory = "/home/nixadmin";
  };

  # ---------------------------------------------------
  # Home Manager - nixadmin packages
  # ---------------------------------------------------

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # Core
    aria2
    binutils
    btop
    bun
    coreutils
    curlFull
    dnsutils
    ethtool
    fastfetch
    file
    iftop
    iotop
    iputils
    lolcat
    mtr
    nmap
    nvtopPackages.amd
    pciutils
    sysstat
    usbutils
    uv
    wget
    which
    xdg-utils

    # Dev
    android-studio
    android-tools
    antigravity
    github-desktop
    kiro

    # Productivity
    affine
    alacritty-graphics
    alacritty-theme
    cherry-studio
    contour
    drawio
    libreoffice
    newelle
    newsflash
    thunderbird
    tor-browser
    vivaldi
    vivaldi-ffmpeg-codecs  

    # Utilities
    hardinfo2
    localsend
    netpeek
    packet
    proton-pass
    vicinae
    vlc
    waveterm
  ];

  home.stateVersion = "25.11";

}
