# ==========================================================================
# Nixos System Packages
# ==========================================================================

{ 
  pkgs, 
  pkgsUnstable, 
  ... 
}:

{
  # Enable unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-38.8.4"
      "electron-39.8.10"
    ];
  };

  # Install applications with provided options
  programs = {
    firefox.enable = true;
    bash.enable = true;
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
     
     # Stable packages

     # Applications
     distrobox
     distroshelf
     gearlever
     input-leap
     normcap
     podman
     podman-compose
     podman-desktop
     pods
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
     tesseract
     virt-manager
     warehouse

     # Network
     tailscale
     tail-tray

     # Security
     burpsuite
     caido-cli
     caido-desktop
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
     android-tools
     bat
     cacert
     cachix
     cargo
     cmake
     deadnix
     dbus
     direnv
     gdb
     git
     gparted
     gsettings-desktop-schemas
     i2c-tools
     javaPackages.compiler.openjdk25
     libvirt
     llvm
     manix
     nfs-utils
     nil
     nixd
     nix-index
     nix-template
     nix-tree
     nix-update
     nixpkgs-fmt
     nixpkgs-review
     nodejs_24
     openssl
     pavucontrol
     perl
     powershell
     python3

  ]) ++ 
  
  # Unstable packages
  (with pkgsUnstable; [
     
    openrgb-with-all-plugins
    warp-terminal
     
  ]);
  
}

