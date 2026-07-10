# ==========================================================================
# Desktop Local LLM Services
# ==========================================================================
{
  lib,
  pkgs,
  pkgsUnstable,
  ...
}:
 
{
  # llmhop Router
  services.llmhop = {
    enable = true;

    settings = {
      listen = "0.0.0.0:8080";
    };

    # Built-in llama.cpp worker management
    llama-cpp = {
      enable = true;
      package = pkgs.llama-cpp;
      models."qwen3.5-9b" = {
        port = 30001;
        settings = {
          hf-repo = "unsloth/Qwen3.5-9B-GGUF:Q4_K_M";
          n-gpu-layers = 99;
          ctx-size = 8192;
          no-webui = true;
        };
      };
      
      models."gemma-4-12b" = {
        port = 8033;
        settings = {
          host = "0.0.0.0";
          hf-repo = "unsloth/gemma-4-GGUF:gemma-4-12B-it-qat-UD-Q4_K_XL";
          n-gpu-layers = 99;
          ctx-size = 4096;
        };
      };
    };
  };
  
  # Enable LibreChat Native Systemd Service
  services.librechat = {
    enable = true;
    meilisearch.enable = true;
    enableLocalDB = true;
    
    host = "0.0.0.0";
    env.PORT = 3080; 
    openFirewall = true;
    group = "librechat";
    
    settings = {
      endpoints = {
        custom = [
          {
            name = "Local LLMhop";
            baseURL = "http://127.0.0"; 
            apiKey = "sk-local-token";
            models = {
              default = [ "gemma-4-12b" ];
              fetch = false; 
            };
            titleConvo = true;
            summarize = false;
          }
        ];
      };
    };
  };
}
