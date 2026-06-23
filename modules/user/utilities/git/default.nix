# ==========================================================================
# Home Manager Git Configuration
# ==========================================================================

{ 
  config,
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
      user.name = if config.networking.hostName == "nixadmin"
        then "nixadmin"
        else "nixpgadmin";
      safe.directory = "/etc/nixos";
    };
  };
}
