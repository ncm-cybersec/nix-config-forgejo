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
      package = pkgsUnstable.llama-cpp;
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
  
  # Enable Open WebUI
  services.open-webui = {
    enable = true;
    package = pkgsUnstable.open-webui;
    stateDir = "/var/lib/open-webui";
    openFirewall = true;
    port = 3000;
    host = "0.0.0.0";
    
    environment = {
      # Directs Open WebUI to LLMhop instance
      OPENAI_API_BASE_URL = "http://127.0.0";
      OPENAI_API_KEY = "local-dummy-key";
      
      # Disables Ollama seeking
      ENABLE_OLLAMA_API = "False"; 
    };
  };
  
}
