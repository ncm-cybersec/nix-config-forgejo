# ==========================================================================
# Home Manager Git Conf
# ==========================================================================

{ 
  config,
  pkgs,
  ... 
}:

{
  programs.git.enable = true;
  programs.git.settings.user.name = "nixadmin";
  programs.git.settings.user.email = "nciampamartin@proton.me";
  programs.git.settings = {
    safe.directory = "/etc/nixos";
  };
  
  programs.ssh = {
    enable = true;
  };

}
