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
    aven
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
              "hf.co/RavichandranJ/Dolphin3-Cyber-8B-GGUF:Q8_0" = {
                name = "Dolphin3-Cyber";
              };
              "gemma4:12b" = {
                name = "Gemma4";
              };
              "ornith:9b" = {
                name = "Ornith";
              };
              "qwen2.5-coder:14b" = {
                name = "Qwen2.5";
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
