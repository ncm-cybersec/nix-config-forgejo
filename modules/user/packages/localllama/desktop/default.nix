# ==========================================================================
# Desktop Local LLM - AIChat, Aider, Fabric
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
    package = pkgs.aichat;
    
    settings = {
      default_model = "llmhop:qwen3.5-9b";
      clients = [
        {
          type = "openai";
          name = "llmhop";
          api_base = "http://127.0.0.1:8080/v1";
          api_key = "local-dummy-key";
          models = [
            {
              name = "qwen3.5-9b";
              max_input_tokens = 8192;
            }
          ];
        }
      ];
      
      highlight_theme = "dracula"; 
      preambles = {
        default = ''
          You are a concise, agentic AI embedded inside a custom NixOS Konsole terminal running Zsh.
          You are an expert of Technology, with a focus on Cybersecurity, Network Engineering, Programming, DevOps/IaC, and all things Linux/NixOS.          
          The user's theme is Rose Pine / Catppuccin with glass blur effects. 
          When rendering code blocks, scripts, or commands:
          1. Always wrap code in explicit language Markdown blocks (e.g., ```nix or ```bash).
          2. Keep conversational filler text to an absolute minimum.
          3. Prioritize NixOS declarative syntax (flakes, modules) when asked system questions.
        '';
      };
    };
  };

  programs.aider-chat = {
    enable = true;
    package = pkgs.aider-chat;
    
    settings = {
      openai-api-base = "http://127.0.0.1:8080/v1";
      openai-api-key = "local-dummy-key";
      
      model = "openai/qwen3.5-9b";
      editor-model = "openai/qwen3.5-9b";
      
      auto-commits = false;
      dark-mode = true;
      stream = true;
    };
  };

  programs.fabric-ai = {
    enable = true;
    package = pkgs.fabric-ai;
    enableZshIntegration = true;
    enablePatternsAliases = true;
  };

  home.file = {
    ".config/fabric/.env".text = ''
      DEFAULT_MODEL=qwen3.5-9b
      OPENAI_BASE_URL=http://127.0.0.1:8080/v1
    '';
    ".config/fabric/openai_api_key".text = "local-dummy-key";
  };
}
