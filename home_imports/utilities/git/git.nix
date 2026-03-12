# ---------------------------------------------------
# Home Manager Git Conf
# ---------------------------------------------------

{ config, pkgs, ... }:

{

  programs.git.enable = true;
  programs.git.settings.user.name = "nixadmin";
  programs.git.settings.user.email = "ncm-cybersec@users.noreply.github.com";
  programs.git.settings.safe.directory = [
    "/etc/nixos"
    "/home/nixadmin/nix-config"
  ];
  
}
