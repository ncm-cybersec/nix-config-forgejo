# ==========================================================================
# Local LLM Stack  - User Services
# ==========================================================================

{ 
  inputs,
  pkgs,
  ... 
}:

{
  
  # Numtide/LLM-agents Packages
  home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [ 
    gitnexus
    gno
    herdr
    kilocode-cli
    letta-code
    memvid-cli
    nanocoder
    oh-my-opencode
    skills
  ];
  
  # Enable Opencode using pkg from llmagents flakes
  programs = {
    opencode = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
      
      # opencode.json
      settings = {
        provider = {
          ollama = {
            npm = "@ai-sdk/openai-compatible";
            name = "Ollama";
            baseURL = "http://127.0.0.1:11434/v1";
            models = {
              "qwen2.5-coder:14b" = {
                name = "Qwen2.5";
              };
              "gemma4:12b" = {
                name = "Gemma4";
              };
              "qwen3.5:9b" = {
                name = "Qwen3.5";
              };
            };
          };
        };
      };
    };
  };
}
