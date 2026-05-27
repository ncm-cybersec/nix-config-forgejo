# ---------------------------------------------------
# Nixos Home Manager Conf
# ---------------------------------------------------

{ pkgs, pkgsUnstable, ... }:

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

    # Stable packages
    
    # Core
    aria2
    binutils
    btop
    bun
    coreutils
    curlFull
    desktop-file-utils
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
    cherry-studio
    drawio
    joplin-desktop
    libreoffice-fresh
    logseq
    marktext
    newelle
    newsflash
    obsidian
    thunderbird
    tor-browser
    
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
    })
    vivaldi-ffmpeg-codecs
    
    # Utilities
    hardinfo2
    localsend
    netpeek
    packet
    vicinae
    vlc
    
  ]) ++ 
  
  # Unstable packages 
  (with pkgsUnstable; [
    
    antigravity
    code-cursor
    cursor-cli
    kiro
    kiro-cli
    lmstudio
    opencode-desktop
    proton-pass
    proton-pass-cli
    tabularis
    windsurf
    zed-editor
       
  ]);

  home.stateVersion = "25.11";

}
