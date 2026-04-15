# ---------------------------------------------------
# Nixos Home Manager Conf
# ---------------------------------------------------

{ config, inputs, pkgs, pkgsUnstable, ... }:

{
  imports =
    [
      ./modules/user
    ];

  home = {
    username = "nixadmin";
    homeDirectory = "/home/nixadmin";
  };

  # ---------------------------------------------------
  # Home Manager - nixadmin packages
  # ---------------------------------------------------

  # Packages that should be installed to the user profile.
  home.packages = (with pkgs; [

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
    nvtopPackages.nvidia
    pciutils
    sysstat
    tree
    usbutils
    uv
    wget
    which
    xdg-utils

    # Dev
    android-studio
    android-tools
    github-desktop
        
    # Productivity
    affine
    alacritty-graphics
    alacritty-theme
    cherry-studio
    drawio
    joplin-desktop
    libreoffice
    logseq
    marktext
    newelle
    newsflash
    obsidian
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

  ]) ++ 
  
  (with pkgsUnstable; [
    
    antigravity
    lmstudio
    opencode-desktop
    toolhive
   
  ]);

  home.stateVersion = "25.11";

}
