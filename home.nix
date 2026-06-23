# ==========================================================================
# Home Manager Configuration
# ==========================================================================

{ 
  config,
  pkgs, 
  pkgsUnstable,
  username,
  ... 
}: 

{
  imports =
    [
      ./modules/user
    ];

  # Use the home directory of the user running the command, required for multiple hosts to share the same home-manager configuration for uniformity across systems.
  
  # Username is defined for each host in flake.nix (line 120, 171) and passed to home-manager using extraSpecialArgs.
  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  # Packages installed to user profile.
  home.packages = (with pkgs; [

    # Stable packages
    
    # Core & Desktop utilities (CLI)
    btop
    iftop
    iotop
    nvtopPackages.nvidia
    sysstat

    aria2
    bun
    curlFull
    socat
    uv
    wget

    fastfetch
    lolcat
    tree
    which

    binutils
    cacert
    coreutils
    desktop-file-utils
    dnsutils
    ethtool
    file
    ipcalc
    iputils
    ldns
    lsof
    ltrace
    mtr
    nmap
    nssTools
    pciutils
    poppler
    strace
    tcpdump
    usbutils
    xdg-utils

    # AI & Dev Tools
    android-studio
    android-tools
    cherry-studio
    github-desktop
            
    # Office & Productivity
    affine
    discord
    drawio
    ferdium
    joplin-desktop
    libreoffice-fresh
    marktext
    newsflash
    obsidian
    obs-studio
    onlyoffice-desktopeditors
    slack
    spotify
    tor-browser
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
    })
    vivaldi-ffmpeg-codecs
    zoom-us
    
    # Utilities
    hardinfo2
    localsend
    rustdesk
    vicinae
    vlc
    warp
    
  ]) ++ 
  
  # Unstable packages 
  (with pkgsUnstable; [
    
    # nixpkgs-unstable defined as pkgsUnstable in flake.nix (line 72-76) and passed to home-manager/user modules using extraSpecialArgs (lines 111-113).
    
    antigravity
    code-cursor
    cursor-cli
    kiro
    kiro-cli
    proton-authenticator
    proton-pass
    proton-vpn
    proton-vpn-cli
    tabularis
    zed-editor
       
  ]);

  home.stateVersion = "25.11";

}
