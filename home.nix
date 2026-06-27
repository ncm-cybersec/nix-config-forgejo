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
 
  # Username is defined for each host in flake.nix, passed to home-manager using extraSpecialArgs
  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  # Packages installed to user profiles
  home.packages = (with pkgs; [

    # Stable packages
    
    # Dev
    android-studio
    android-tools
    cherry-studio
    github-desktop
            
    # Office
    affine
    drawio
    joplin-desktop
    libreoffice-fresh
    marktext
    obsidian
    onlyoffice-desktopeditors

    # Productivity
    discord
    ferdium
    newsflash
    obs-studio
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
  
  (with pkgsUnstable; [

    # Unstable packages
    antigravity
    code-cursor
    cursor-cli
    kiro
    kiro-cli
    tabularis
    zed-editor
       
  ]);

  home.stateVersion = "25.11";

}
