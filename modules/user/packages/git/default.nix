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

  home.packages = with pkgs; [
    
    # SSH Tools
    croc
    openssl
    ssh-to-age
    ssh-to-pgp
    ssh-tools
    step-cli
    termscp

    # Git Tools
    gitfetch
    git-get
    gitlint
    gitnr
    git-ls
    git-pages
    git-pages-cli
    gitsign
    git-toolbelt
    gittuf

  ];

  # SOPS secret for remote repo
  sops.secrets.forgejo_desktop_ssh_config = {
    
  };

  # Enable SSH
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        addKeysToAgent = "yes";
      };
    };
    # SOPS secret for remote repo
    includes = [
      config.sops.secrets.forgejo_desktop_ssh_config.path
    ];
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
