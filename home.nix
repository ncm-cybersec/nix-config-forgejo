# ==========================================================================
# Home Manager Configuration
# ==========================================================================

{ 
  pkgs, 
  pkgsUnstable,
  ... 
}: 

{
  imports =
    [
      ./modules/user
    ];

  home = {
    username = "nixadmin";
    homeDirectory = "/home/nixadmin";
  };

  # Packages installed to user profile.
  home.packages = (with pkgs; [

    # Stable packages
    
    # Core & Desktop utilities (CLI)
    aria2
    binutils
    btop
    bun
    cacert
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
    nssTools
    nvtopPackages.nvidia
    pciutils
    sysstat
    tree
    usbutils
    uv
    wget
    which
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
