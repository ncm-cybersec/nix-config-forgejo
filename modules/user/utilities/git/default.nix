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
  includes = [
    { path = config.sops.secrets.git_config_user.path; }
  ];
  programs.git.settings = {
    safe.directory = "/etc/nixos";
  };
  
}
