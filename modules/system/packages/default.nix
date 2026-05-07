# ---------------------------------------------------
# Nixos System Packages
# ---------------------------------------------------

{ config, inputs, pkgs, pkgsUnstable, ... }:

{

  # Enable unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-37.10.3"
      "electron-38.8.4"
    ];
  };

  # Install applications with provided options
  programs = {
    firefox.enable = true;
    adb.enable = true;
    bash.enable = true;
    kdeconnect.enable = true;
    virt-manager.enable = true;
    
    appimage = {
      enable = true;
      binfmt = true;
    };  

    fuse = {
      enable = true;
      userAllowOther = true;
    };
  };

  environment.systemPackages = (with pkgs; [
     
     # Applications
     distrobox
     distroshelf
     gearlever
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
     rclone
     remote-exec
     rsync
     virt-manager
     warehouse

     # Network
     tailscale
     tail-tray

     # Security
     burpsuite
     caido
     ghidra
     maltego
     netscanner
     netsniff-ng
     nmap
     suricata
     wireshark
     zeek
     zenmap
     
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
     javaPackages.compiler.openjdk25
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
     pavucontrol
     perl
     powershell
     python3

  ]) ++ 
  
  (with pkgsUnstable; [
     
    warp-terminal
     
  ]);
  
}
