# ==========================================================================
# Nixos System Packages
# ==========================================================================

{ 
  inputs,
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
    };
    
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
    
    # Applications
    appimage-run
    gearlever
    inputs.app-manager.packages.x86_64-linux.default
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
