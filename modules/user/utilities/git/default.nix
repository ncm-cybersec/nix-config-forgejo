# ==========================================================================
# Home Manager - Git & SSH Configuration
# ==========================================================================

{ 
  config,
  hostName,
  inputs,
  pkgs,
  ... 
}:

{

  # SOPS secret for remote repo
  sops.secrets.forgejo_desktop_ssh_config = {
    
  };

  # Enable SSH
  programs.ssh = {
    enable = true;
    includes = [
      config.sops.secrets.forgejo_desktop_ssh_config.path
    ];
    extraConfig = ''
      Host *
        AddKeysToAgent yes
    '';
  };

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
