# ---------------------------------------------------
# Home Manager Git Conf
# ---------------------------------------------------

{ config, pkgs, ... }:

{

  programs.git = {
    enable = true;
    userName = "nixadmin";
    userEmail = "nciampamartin@proton.me";
    extraConfig = {
      safe.directory = "/etc/nixos";
    };
  };

}
