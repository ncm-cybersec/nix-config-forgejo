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

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    enableDebugInfo = true;
    enableNixpkgsReleaseCheck = true;
    stateVersion = "25.11";
  };

  home.packages = (with pkgs; [
    
    # Dev
    android-studio
    android-tools
    cherry-studio
    github-desktop

    # Office
    affine
    drawio
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
    zoom-us

    # Utilities
    hardinfo2
    localsend
    vicinae
    vlc
    
  ]) ++ 
  
  (with pkgsUnstable; [

    zed-editor

  ]) ++ 
  
  (with inputs.antigravity-nix.packages.${pkgs.stdenv.hostPlatform.system}; [

    google-antigravity-no-fhs
    google-antigravity-ide-no-fhs
    google-antigravity-cli

  ]);
  
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
}
