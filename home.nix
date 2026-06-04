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
    
    # Core CLI tools
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

    # AI & Dev
    android-studio
    android-tools
    beekeeper-studio
    cherry-studio
    github-desktop
    newelle
        
    # Office & Productivity
    affine
    bluemail
    discord
    drawio
    ferdium
    joplin-desktop
    libreoffice-fresh
    marktext
    newsflash
    obsidian
    obs-studio
    slack
    spotify
    thunderbird
    tor-browser
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
    })
    vivaldi-ffmpeg-codecs
    zoom-us
    
    # Utilities
    hardinfo2
    ksnip
    localsend
    netpeek
    rustdesk
    vicinae
    vlc
    warp
    
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
    zed-editor
       
  ]);

  home.stateVersion = "25.11";

}
