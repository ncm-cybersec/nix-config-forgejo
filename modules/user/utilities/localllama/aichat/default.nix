# ==========================================================================
# Local LLM Stack - User Services
# ==========================================================================

{ 
  hostName,
  pkgs,
  ...
}: 

{
  
  # Local LLM User Services - AIchat, Aider, and Fabric-AI
  programs = {
    
    # Enable AIchat
    aichat = {
      enable = true;
      package = pkgs.aichat;
    
      # Model settings & Ollama integration
      settings = {
        
        # Dynamically select model based on hostname
        default_model = if hostName == "nixadmin"
          then "qwen2.5-coder:14b"
          else "qwen3:4b";
        clients = [
        {
          type = "openai";
          name = "ollama";
          api_base = "http://127.0.0.1:11434/v1";
          api_key = "local-dummy-key";
          models = [
            {
              name = "qwen2.5-coder:14b";
              max_input_tokens = 32768;
            }
            {
              name = "qwen3:4b";
              max_input_tokens = 16384;
            }
          ];
        }
      ];
      
      # Terminal theming & prompt
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

    # Enable Aider-Chat
    aider-chat = {
      enable = true;
      package = pkgs.aider-chat;

      # Model settings & Ollama integration
      settings = {
        openai-api-base = "http://127.0.0.1:11434";
        openai-api-key = "local-dummy-key";
        
        # Dynamically select model based on hostname
        model = if hostName == "nixadmin"
          then "qwen2.5-coder:14b"
          else "qwen3:4b";
          
        editor-model = if hostName == "nixadmin"
          then "qwen2.5-coder:14b"
          else "qwen3:4b";
      
        auto-commits = false;
        dark-mode = true;
        stream = true;
      };
    };
    
    # Enable Fabric-AI
    fabric-ai = {
      enable = true;
      package = pkgs.fabric-ai;
      enableZshIntegration = true;
      enablePatternsAliases = true;
    };
  };
  
  # Fabric-AI Environment Variables
  home.file = {
    ".config/fabric/.env".text = ''
      DEFAULT_MODEL=${if hostName == "nixadmin" then "qwen2.5-coder:14b" else "qwen3:4b"}
      OPENAI_BASE_URL=http://127.0.0.1:11434/v1
    '';
    ".config/fabric/openai_api_key".text = "local-dummy-key";
  };
}
