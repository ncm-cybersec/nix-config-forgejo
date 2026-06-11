# ==========================================================================
# Home Manager Git Conf
# ==========================================================================

{ 
  config,
  pkgs,
  ... 
}:

{
  programs.git = {
    enable = true;
    includes = [
      { path = config.sops.secrets.git_config_user.path; }
    ];
    settings = {
      user.name = "nixadmin";
      safe.directory = "/etc/nixos";
    };
  };
}
