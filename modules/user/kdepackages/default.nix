# ---------------------------------------------------
# Home Manager KDE Plasma Packages
# ---------------------------------------------------

{ config, pkgs, ... }:

{

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # KDE
    kdePackages.dolphin-plugins
    kdePackages.gwenview
    kdePackages.isoimagewriter
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    kdePackages.kalarm
    kdePackages.kamoso
    kdePackages.kate
    kdePackages.kbookmarks
    kdePackages.kcalc
    kdePackages.kcron
    kdePackages.kdeconnect-kde
    kdePackages.kdenlive
    kdePackages.kio
    kdePackages.kio-admin
    kdePackages.kio-extras
    kio-fuse
    kdePackages.kio-gdrive
    kdePackages.kruler
    kdePackages.ksystemlog
    kdePackages.partitionmanager
    kdePackages.sddm-kcm
    (python3.withPackages (ps: with ps; [
      dbus-python
      pygobject3
    ]))
    wayland-utils
  ];

}
