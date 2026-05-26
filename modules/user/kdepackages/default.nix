# ---------------------------------------------------
# Home Manager KDE Plasma Packages
# ---------------------------------------------------

{ config, pkgs, ... }:

{

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # KDE
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
    kio-fuse
    kdePackages.kio-gdrive
    kdePackages.kio-zeroconf
    kdePackages.korganizer
    kdePackages.kruler
    kdePackages.ksystemlog
    kdePackages.partitionmanager
    kdePackages.sddm-kcm
    kdePackages.kweather
    kdePackages.kweathercore

    # Fix for KDE Plasma Applet/Widgets
    (python3.withPackages (ps: with ps; [
      dbus-python
      pygobject3
    ]))
    wayland-utils
  ];

}
