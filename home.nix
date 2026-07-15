# ==========================================================================
# Home Manager Configuration
# ==========================================================================

{ 
  inputs,
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
 
  # Username is defined for each host in flake.nix, passed to home-manager via extraSpecialArgs
  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };
  
  programs = {
    nh = {
      enable = true;
      package = pkgs.nh;
      
      clean = {
        enable = true;
        dates = "Sun *-*-* 15:00:00";
        extraArgs = "--keep 5 --keep-since 3d";
      };
    };
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

    zed-editor
       
  ]) ++ 
  
  (with inputs.antigravity-nix.packages.${pkgs.stdenv.hostPlatform.system}; [
    
    # Antigravity 2.0
    google-antigravity-no-fhs       # AGY Base App
    google-antigravity-ide-no-fhs   # AGY IDE
    google-antigravity-cli          # AGY CLI
  
  ]);

  home.stateVersion = "25.11";
}
