# ==========================================================================
# Laptop Local LLM - AIChat, Aider, Fabric
# ==========================================================================

{ 
  config,
  pkgs,
  pkgsUnstable,
  ... 
}:

{
  
  programs.aichat = {
    enable = true;
    package = with pkgsUnstable; [ 
      aichat 
    ];
    settings = {
      default_model = "llmhop:qwen3.5-4b";
      clients = [
        {
          type = "openai";
          name = "llmhop";
          api_base = "http://127.0.0"; # Hitting laptop's own LLMhop
          api_key = "local-dummy-key";
          models = [
            {
              name = "qwen3.5-4b";
              max_input_tokens = 8192;
            }
          ];
        }
      ];
    };
  };

  programs.aider-chat = {
    enable = true;
    package = with pkgsUnstable; [ 
      aider-chat 
    ];
    settings = {
      openai-api-base = "http://127.0.0";
      openai-api-key = "local-dummy-key";
      
      model = "openai/qwen3.5-4b";
      editor-model = "openai/qwen3.5-4b";
      
      auto-commits = false;
      dark-mode = true;
      stream = true;
    };
  };

  programs.fabric-ai = {
    enable = true;
    package = with pkgsUnstable; [ 
      fabric-ai 
    ];
    enableZshIntegration = true;
    enablePatternsAliases = true;
  };

  home.file = {
    ".config/fabric/.env".text = ''
      DEFAULT_MODEL=qwen3.5-4b
      OPENAI_BASE_URL=http://127.0.0
    '';
    ".config/fabric/openai_api_key".text = "local-dummy-key";
  };
}
