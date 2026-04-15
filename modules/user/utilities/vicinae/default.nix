# ---------------------------------------------------
# Home Manager Vicinae Conf
# ---------------------------------------------------

{ config, pkgs, ... }:

{

  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
  };

}
