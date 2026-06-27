# ==========================================================================
# User - System Packages
# ==========================================================================

{ 
  pkgs, 
  ... 
}:

{

  # User core system packages
  home.packages = with pkgs; [
    
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

    alejandra
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

  ];
}