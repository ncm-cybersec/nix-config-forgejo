# ==========================================================================
# Local LLM Stack - System Services
# ==========================================================================

{
  hostName,
  lib,
  pkgsUnstable,
  ...
}:

{
  
  # Local LLM System Services - Ollama
  services = {
    
    # Enable Ollama
    ollama = {
      enable = true;
      package = pkgsUnstable.ollama-cuda;     
      openFirewall = true;
      host = "127.0.0.1";
      port = 11434;
      
      syncModels = true;
      loadModels = lib.mkMerge [
        (lib.mkIf (hostName == "nixadmin") [
          #"gemma4:12b"
          #"ornith:9b"
          "qwen2.5-coder:14b"
          #"qwen3.5:9b"
        ])
        
        (lib.mkIf (hostName == "nixpgadmin") [
          #"qwen2.5-coder:7b"
          "qwen3:4b"
          #"qwen3.5:4b"
        ])
      ];
    
      # Enable Flash Attention globally for the daemon
      environmentVariables = {
        OLLAMA_FLASH_ATTENTION = "1";
      };
    };
  };
}