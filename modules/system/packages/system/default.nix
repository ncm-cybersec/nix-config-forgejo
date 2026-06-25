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
     input-leap
     normcap
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
     
     # System
     android-tools
     argc
     bat
     cargo
     cmake
     direnv
     git
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
     
     dbus
     efibooteditor
     efibootmgr
     efitools
     gdb
     gparted
     i2c-tools

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

  ]) ++ 
  
  # Unstable packages
  (with pkgsUnstable; [
         
    openrgb-with-all-plugins
     
  ]);
  
}

