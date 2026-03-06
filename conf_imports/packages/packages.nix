# ---------------------------------------------------
# Nixos System Packages
# ---------------------------------------------------

{ config, pkgs, ... }:

{

  # Install firefox.
  programs.firefox.enable = true;

  # Enable ADB/Scrcpy
  programs.adb.enable = true;

  # Enable appimage support
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # Enable bash
  programs.bash.enable = true;

  # Enable kdeconnect
  programs.kdeconnect.enable = true;

  # Enable virt-manager
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [

     # Applications
     distrobox
     distroshelf
     ollama-cuda
     podman
     podman-compose
     podman-desktop
     qemu
     # QEMU UEFI support
     (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
     virt-manager

     # System
     bat
     cachix
     cargo
     cmake
     deadnix
     dbus
     direnv
     gdb
     git
     gparted
     i2c-tools
     libvirt
     llvm
     manix
     nfs-utils
     nix-index
     nix-template
     nix-tree
     nix-update
     nixpkgs-fmt
     nixpkgs-review
     nodejs_24
     openrgb-with-all-plugins
     pavucontrol
     perl
     python3
  ];

}
