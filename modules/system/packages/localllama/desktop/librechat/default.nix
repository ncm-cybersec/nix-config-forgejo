# ==========================================================================
# Librechat w/ Meilisearch & MongoDB
# ==========================================================================

{
  config,
  pkgs,
  ...
}:

{

  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";
    
    secrets = {
      librechat = {
        sopsFile = ../../../../../../secrets/localllama/librechat.yaml;
        format = "yaml";
        key = "";
        owner = "nixadmin";
        group = "librechat";
        mode = "0440";
      };
      
      HUGGINGFACE_TOKEN = {
        sopsFile = ../../../../../../secrets/localllama/huggingface.yaml;
        owner = "nixadmin";
        group = "librechat";
        mode = "0440";
      };
      
      MEILI_MASTER_KEY = {
        sopsFile = ../../../../../../secrets/localllama/meilisearch.yaml;
        owner = "nixadmin";
        group = "librechat";
        mode = "0440";
      };
      
      MONGO_URI = {
        sopsFile = ../../../../../../secrets/localllama/mongodb.yaml;
        owner = "nixadmin";
        group = "librechat";
        mode = "0440";
      };
    };
  };
  
  services = {

    # Meilisearch
    meilisearch = {
      enable = true;
      package = pkgs.meilisearch;
      masterKeyFile = config.sops.secrets.MEILI_MASTER_KEY.path;
    };

    librechat = {
      enable = true;
      package = pkgs.librechat;
      enableLocalDB = true;
      
      credentials = {
        HUGGINGFACE_TOKEN = config.sops.secrets.HUGGINGFACE_TOKEN.path;
        MONGO_URI = config.sops.secrets.MONGO_URI.path;
      };
      
      credentialsFile = config.sops.secrets.librechat.path;
      
      group = "librechat";
      user = "nixadmin";
      dataDir = "/home/nixadmin/librechat";
      env = {
        HOST = "0.0.0.0";
        PORT = 3080;
      };

      settings = {        
        endpoints = {
          custom = [
            {
              name = "LLMhop WebUI";
              baseURL = "http://127.0.0.1:8080/v1";
              apiKey = "sk-local-token";
              models = {
                default = [
                "gemma4-12b"
                ];
                fetch = false;
              };
              titleConvo = true;
              titleModel = "gemma4-12b";
              dropParams = [ "stop" ];
            }
          ];
        };
      };
    };
  };
}
