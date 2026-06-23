# ==========================================================================
# Home Manager Git Configuration
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
      # Dynamically choose username based on which host is building the configuration
      user.name = if config.networking.hostName == "nixadmin"
        then "nixadmin"
        else "nixpgadmin";
      safe.directory = "/etc/nixos";
    };
  };
}
