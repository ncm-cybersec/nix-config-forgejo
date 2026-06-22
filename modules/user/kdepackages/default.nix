# ==========================================================================
# Home Manager KDE Plasma Packages
# ==========================================================================

{ 
  inputs,
  pkgs,
  pkgsUnstable,
  ... 
}:

{

  services.kdeconnect.enable = true;

  # Packages that should be installed to the user profile.
  home.packages = (with pkgs; [

    # Stable

    # Fix for KDE Plasma Applet/Widgets crashing or causing issues w/ plasmashell
    (python3.withPackages (ps: with ps; [
      dbus-python
      pygobject3
    ]))

    utterly-nord-plasma
    wayland-utils
    
  ]) ++ 
  
  (with pkgsUnstable; [
  
    # nixpkgs-unstable defined as pkgsUnstable in flake.nix (line 72-76) and passed to home-manager/user modules using extraSpecialArgs (lines 111-113).

    # Unstable KDE packages, because stable versions are significantly outdated
    kdePackages.akonadi
    kdePackages.akonadi-calendar
    kdePackages.dolphin-plugins
    kdePackages.dragon
    kdePackages.filelight
    kdePackages.ghostwriter
    kdePackages.gwenview
    kdePackages.isoimagewriter
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    kdePackages.kalarm
    kdePackages.kamoso
    kdePackages.kate
    kdePackages.kbookmarks
    kdePackages.kcalc
    kdePackages.kcalendarcore
    kdePackages.kcalutils
    kdePackages.kcron
    kdePackages.kdenlive
    kdePackages.kdnssd
    kdePackages.kio
    kdePackages.kio-admin
    kdePackages.kio-extras
    kdePackages.kio-gdrive
    kdePackages.kio-zeroconf
    kdePackages.korganizer
    kdePackages.kruler
    kdePackages.ksystemlog
    kdePackages.partitionmanager
    kdePackages.sddm-kcm
    kdePackages.kweather
    kdePackages.kweathercore
    
  ]);

}
