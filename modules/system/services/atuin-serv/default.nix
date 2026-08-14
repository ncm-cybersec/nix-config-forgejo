# ==========================================================================
# Atuin - Self-Hosted Sync Server
# ==========================================================================

{ 
  config,
  ... 
}:

{
  
  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
    
    secrets = {
      
      # Atuin DB URI
      atuin-env = {
        sopsFile = ../../../../secrets/services/atuin.yaml;
        format = "yaml";
      };
    };
  };

  services.atuin = {
    enable = true;
    environmentFile = config.sops.secrets.atuin-env.path;
    host = "0.0.0.0";
    port = 8888;
    openRegistration = true;
    openFirewall = true;
    maxHistoryLength = 8192;

    # Enable PostgreSQL DB locally
    database = {
      createLocally = true;
    };
  };
}
