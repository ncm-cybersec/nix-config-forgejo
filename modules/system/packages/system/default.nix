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

  # Install applications using Nix options
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
     gearlever
     normcap
     qemu
     # QEMU UEFI support
     (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
        qemu-system-x86_64 \
          -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
          "$@"
      '')
     tesseract
     virt-manager
     
     # Nix
     cachix
     deadnix
     manix
     nil
     nixd
     nix-index
     nix-output-monitor
     nix-template
     nix-tree
     nix-update
     nixpkgs-fmt
     nixpkgs-review
     python3Packages.flake8
     python3Packages.flake8-bugbear
     python3Packages.flake8-class-newline
     python3Packages.flake8-debugger
     python3Packages.flake8-deprecated
     python3Packages.flake8-docstrings
     python3Packages.flake8-import-order
     python3Packages.flake8-length
     python3Packages.flake8-quotes
     python3Packages.pytest-flake8

     # Recovery Utilities
     ntfs3g
     ntfsprogs
     ntfsprogs-plus
     partclone
     partclone-utils
     testdisk

     # System
     android-tools
     argc
     bat
     cargo
     cmake
     dbus
     direnv
     gdb
     git
     gparted
     gsettings-desktop-schemas
     javaPackages.compiler.openjdk25
     jq
     jql
     libvirt
     llvm
     nodejs_24
     perl
     powershell
     python3


  ]) ++ 
  
  # Unstable packages
  (with pkgsUnstable; [
         
    openrgb-with-all-plugins
     
  ]);
  
}

