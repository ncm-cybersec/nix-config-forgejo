# ==========================================================================
# Appimage Module - Core & Imports
# ==========================================================================

{
  inputs,
  pkgs,
  ...
}: 

{
  
  imports = [
    ./appimage-updater
  ];
  
  # Fix TLS/SSL certificate issues with AppManager Flake
  system.activationScripts.tls-compat = {
    text = ''
      mkdir -p /etc/ssl/certs
      ln -sfn /etc/static/ssl/certs/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt
    '';
  };
  
  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
    
    fuse = {
      enable = true;
      userAllowOther = true;
    };
  };
  
  environment.systemPackages = with pkgs; [
    appimage-run
    inputs.app-manager.packages.x86_64-linux.default
  ];

}