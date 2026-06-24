# ==========================================================================
# Home Manager Git Configuration
# ==========================================================================

{ 
  config,
  hostName,
  pkgs,
  ... 
}:

{
  # Enable Git
  programs.git = {
    enable = true;
    includes = [
      { path = config.sops.secrets.git_config_user.path; }
    ];
    settings = {
      # Dynamically choose username based on host
      user.name = if hostName == "nixadmin"
        then "nixadmin"
        else "nixpgadmin";
      safe.directory = "/etc/nixos";
    };
  };
}
