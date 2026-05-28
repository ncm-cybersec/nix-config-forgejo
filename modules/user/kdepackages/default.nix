# ---------------------------------------------------
# Home Manager KDE Plasma Packages
# ---------------------------------------------------

{ pkgs, pkgsUnstable, ... }:

{

  # Packages that should be installed to the user profile.
  home.packages = (with pkgs; [

    # Stable 

    # Fix for KDE Plasma Applet/Widgets
    (python3.withPackages (ps: with ps; [
      dbus-python
      pygobject3
    ]))
    wayland-utils
    
  ]) ++ 
  
  (with pkgsUnstable; [
  
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
    kdePackages.kdeconnect-kde
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
