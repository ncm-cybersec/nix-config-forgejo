# ==========================================================================
# Nixos System Packages
# ==========================================================================

{ 
  pkgs, 
  pkgsUnstable, 
  ... 
}:

{
  
  # Install applications using Nix options
  programs = {
    
    nix-index = {
      enable = true;
      package = pkgs.nix-index;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld;
      libraries = with pkgs; [
        stdenv.cc.cc
        openssl
        curl
        glibc
      ];
    };
    
    firefox.enable = true;
    bash.enable = true;
    virt-manager.enable = true;
  };
  
  environment.systemPackages = (with pkgs; [
    
    # Applications
    normcap
    qemu
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
    nix-output-monitor
    nix-template
    nix-tree
    nix-update
    nixpkgs-fmt
    nixpkgs-review
    witr

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
    fuse
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
