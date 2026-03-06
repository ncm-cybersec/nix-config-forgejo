{ config, pkgs, vicinae, ... }:

{
  imports =
    [
      ./home_imports/home_packages/kdepackages.nix
      ./home_imports/shell/bash/bash.nix
      ./home_imports/shell/nushell/nushell.nix
      ./home_imports/shell/tmux/tmux.nix
      ./home_imports/utilities/git/git.nix
      ./home_imports/utilities/vicinae/vicinae.nix
      vicinae.homeManagerModules.default
    ];

  home.username = "nixadmin";
  home.homeDirectory = "/home/nixadmin";

  # ---------------------------------------------------
  # Home Manager - nixadmin packages
  # ---------------------------------------------------

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # CLI tools
    gemini-cli
    github-copilot-cli
    goose-cli
    opencode

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
    rclone
    rclone-ui
    vicinae
    vlc
    waveterm
  ];


  home.stateVersion = "25.11";

}
